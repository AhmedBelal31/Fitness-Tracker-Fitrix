import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/sections_cubit.dart';
import '../cubit/sections_state.dart';
import '../widgets/section_card.dart';
import 'section_exercises_screen.dart';

class SectionsListScreen extends StatefulWidget {
  const SectionsListScreen({super.key});

  @override
  State<SectionsListScreen> createState() => _SectionsListScreenState();
}

class _SectionsListScreenState extends State<SectionsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SectionsCubit>().loadSections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text(
          'Exercise Sections',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SectionsCubit, SectionsState>(
        listener: (context, state) {
          if (state is SectionsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SectionsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFD700)),
            );
          }

          if (state is SectionsLoaded) {
            if (state.sections.isEmpty) {
              return Center(
                child: Text(
                  'No sections available',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: const Color(0xFFFFD700),
              backgroundColor: const Color(0xFF2A2A2A),
              onRefresh: () async {
                context.read<SectionsCubit>().loadSections();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.sections.length,
                itemBuilder: (context, index) {
                  final section = state.sections[index];
                  return SectionCard(
                    section: section,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SectionExercisesScreen(
                            sectionId: section.id,
                            sectionName: section.name,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          if (state is SectionsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load sections',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SectionsCubit>().loadSections();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
