<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Appointments;
use App\Models\Reviews;
use Illuminate\Support\Facades\Auth;

class DocsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //get doctor's appointment, patients and display on dashboard
                $doctor = Auth::user();
                $appointments = Appointments::where('doc_id', $doctor->id)->where('status', 'upcoming')->get();
                $reviews = Reviews::where('doc_id', $doctor->id)->where('status', 'active')->get();

                //return all data to dashboard
                return view('dashboard')->with(['doctor'=>$doctor, 'appointments'=>$appointments, 'reviews'=>$reviews]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
