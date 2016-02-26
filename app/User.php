<?php

namespace App;

use Illuminate\Foundation\Auth\User as Authenticatable;
use App\Log;

class User extends Authenticatable
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    protected $casts = [
        'demographic_data' => 'array'
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    public function logs()
    {
        return $this->hasMany(Log::class);
    }
}