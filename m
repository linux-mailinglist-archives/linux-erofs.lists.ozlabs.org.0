Return-Path: <linux-erofs+bounces-1423-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FDC7C398
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Nov 2025 03:56:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCxYk19TBz2yvH;
	Sat, 22 Nov 2025 13:56:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763780186;
	cv=none; b=R+msIUXJ0KbAgO2bmIWxGX8ZaWsV8YvMmKLynSOOy6y0LELZqb5BV+59qSZmdADLaSuNQWFZiHrAbo34WAS9Kb5OIiPqWbqgRME/3ijI2v4sgsgXoC3rFE4hmgAEMCl5SgDq/FRudlLWRrY5RDx5dnuYcZkqp27XCskrX+o+8Y5Xwsu8PrY1eaLZ+UYU3pcnXDF4KAulKnikjr0bKLjgS7hcmxkKyTZU9KtFi2siaRAscEpAbjnUnKT2QDc87v225La6Wvc/U/c1hQUAy07ugLSqUw5fZyPoptK74Pj5CA+oNBFkrwQMrKK3PEFJpe51rEnF1vSjQWG7lUI9+iq1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763780186; c=relaxed/relaxed;
	bh=vVzCQt1OvXOVG5elbM2Cc5hlhwvn3nh74c9NdSA5XE0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A2HxEKOtQ7hecc+9IeEAS8rwtN5x547PzxdVeaCiHNvDv212EARZ6s7vx+QSykfUJBrYPt1ZvRLrVo1cnohB3FG2SvL4MXZ+n3RKf+XfZfT/DtJB6SLiSCVwouOYkMIcCqJV+RU5aX1CfGa98gdklnhLMElP5514DMUppeK2w/kV0DBquR7ApOwp/FjHR1geGBSlGf5oekfTuyd0110pl/WWIgSg+Qol+TVdyK/BVLrIoC502dYkzUC8ed5f3Y4bSGKXDfxboOupVD79WlpS3gd2q/UaVp7Pbpk/A/n689d+jMQA3eI9SIyHIKldnPK6KKu6do6yAj7sxHklsT0+Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hHwDm7bF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hHwDm7bF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCxYj1kHhz2yFJ
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Nov 2025 13:56:24 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2984dfae043so24039015ad.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 21 Nov 2025 18:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763780182; x=1764384982; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVzCQt1OvXOVG5elbM2Cc5hlhwvn3nh74c9NdSA5XE0=;
        b=hHwDm7bFvvuG7E/CFfNIZXgRqoo30vUS3qlmuArxVMwKCvXiqDoyBCOx987cLg4AdW
         Tq7fzr8jXmv3O3qEj4gn0vSF/vu/Mfx0fH0xkQ1e7tZ6zsk0duI85fmHGrk9iwxf8u6w
         66Y1xXYswlFJhQlIVsEtg0oi1RqZwhM6oc8kyDOFdMfBtwwb0mm7k5S8TZ3k25ypKoIf
         hURN8/MIUoYF5hV6+efUmm3TpZsddIOY0/7+Vyg2EmgoocEOQ5Js6zpOv5lSDeUQr9S/
         pBe63aQntefa8YGBslm4yyIW6suftQt7e1nxEd0IaLLKpczllPwIFvbxpUD3Pq0qW1tS
         dgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763780182; x=1764384982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVzCQt1OvXOVG5elbM2Cc5hlhwvn3nh74c9NdSA5XE0=;
        b=pM/GcPB+bnpStx4C3nVpNULmJk1805nzVACN66Hn3SGBdK+CA+AUwp/+uTMqUeRBwR
         AdRLUEsB2jr0pWVZBh+F7Tz/NNxgduqIPhRn1guOTHHbescBmrwzd8voPgk2MgdjYXK3
         yM6ihW93cu0+22TKPdWC190ClEfPcogNXk9aiR3ezU9MMxr2RoyRu05TB+Xml08OwWfk
         amL5RRaiBykIBMD4JMLrShzV3MNTSrwJmDClKUGCI9VcLBVrX60eSxNEzqEzfbMwtDq9
         /MDiJHPy7yoVG7Yz8Yn/1KxXLAExC+PyyEZC7Awu20HD3/3eXTwU/CsSCRBOh0Mcy2m2
         kAjw==
X-Forwarded-Encrypted: i=1; AJvYcCXfyR55VuviKaAPAA4fms9vD9K2JLlaidCVJXOQFgGxlwL0ZoN9PcruH08gw8wx9Kma24lILmeJMLOggw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyEXcxBrsJiz9LIn73YFYZjZk4im5svIjvRVhP4colI3nMaqO1Z
	+2qxhlSN8cTRcKN9xtJ9zr+heuaE/0uJ6y0aYXI4uQHDjieQmjvad49W
X-Gm-Gg: ASbGncul1jEdXwll4SYoEZXn8jkMO1i8hAtsdE5/wdGx37OzoPr5H4JTctN/VRQcr+u
	3kH9MrO1dP0Xyo1W+JBanRj5r5IatkYj58//vGnRc8pG4d8mqEWtQnfSpq4LT5cKCEfZO7ELFdK
	JaOw0w+8I04SOtciEgkEef9jV7Dl4W/QVsrGAiPuYzjIgsGBS3DgSiB/j/3YdCvCljjQs7e1DEM
	YM/rONxnBsP96v4QdQGUw62Kxwd2P+/MQQ67Mgq0wvXz7zumHmDmXEIJGbZuYBq8uFDArkiTW6c
	RySXJNbWxeEDwhEE5vc3XuphWG564rlt4BXFd2ExzYnXUcSWGGjAotoSr80ZUpss2WMD2JDBi5I
	NPTpSejmiExbxoAt+TWhZP4mptq9/RPh5yQ60bVid1Y3hGuLU6KET4mDpNEmeOnb+/fimdh86ZW
	/Tz5wHbV76eUtoX8W76fkwuA==
X-Google-Smtp-Source: AGHT+IFypSPO+8tyG8O7rhbI6ZBjPFH8FLfZ3baMfPqC6nsdAvQHwI4c6Lf5fdSNx4GMQOOHZe9cIQ==
X-Received: by 2002:a17:903:38cd:b0:295:8a21:155a with SMTP id d9443c01a7336-29b6c572aeemr52246825ad.35.1763780181607;
        Fri, 21 Nov 2025 18:56:21 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2809b6sm69827855ad.76.2025.11.21.18.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 18:56:21 -0800 (PST)
Message-ID: <bb3101cb-21cf-4f36-9130-4482a531c344@gmail.com>
Date: Sat, 22 Nov 2025 10:56:18 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com,
 LKML <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] erofs: limit the level of fs stacking for file-backed
 mounts
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 11/21/25 21:46, Gao Xiang wrote:
> Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
> mounting itself).
> 
> Fixes: fb176750266a ("erofs: add file-backed mount support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Sheng Yong <shengyong1@xiaomi.com>

thanks,
shengyong

