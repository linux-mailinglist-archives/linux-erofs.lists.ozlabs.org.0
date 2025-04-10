Return-Path: <linux-erofs+bounces-188-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E63A84EB3
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 22:53:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYX8Y5YYDz30Vy;
	Fri, 11 Apr 2025 06:53:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744318397;
	cv=none; b=VqX0eKytvCretcGh/NTUJpbxh94ZyYAB612+UxwkgkxbDoQVgvLLNsm7y3j3loIbr0f1Kd7kY0R91sMUnRc/KHn8he97GkS/31VIcwA9dlV/nzNFwQswkGZbW2EVMlLsPYUvvcjGbWQt0hP4Rjl8gqC3ThwmFokTvF6nPRrG3N3GrWdatcIGxlx6QY84LBiVPchZlZuWBFV8ldT8A2Ou0fxJTzxlD1f9HmPwi44tz17EvyQCtD60qsb/Tt/cKQktLfIodWoluUwcbYG5EdkDmuyKa4uHE7nOmyCGhVdj/tfj8xNdum8Yd9vQhdReOwrl/vQD5PDWUA7y2WgFvulMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744318397; c=relaxed/relaxed;
	bh=+6Y88nCpCByqh57KqElWwwc/R0n7e7vwOFEt/7pFPgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLQTWjngZ5z1RciOUQiXc4Y++e5CMGmEZynU9ikquCZWPyIAJjjvgJ3cfqIwRfaGcUmlcseeu0WkMWL+QwuOimww8SPqMZ17+CvIpOJCO8w5C0myZHa672pNek+g/5NYkk3FBrFekjxoVnM3jJ9cXoBcoPAe8NrKWfqX3dLO+yJ7zkHSNXhfc5v1QfEH3Cuwlgo0BNT30JthsuDl36Gd42syxAxJJIguxvZ2ENQW+xcW68yiZkOE5NAqXk2G9hxFd0CFX+BeFvsNt58a2t3xLRjkOToDoh11dHPbTfhW7o4RRx9vSifSUpxevnIizJcOw+ehk7gjj7nzvRGsWw3vxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Du0NV5jU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Du0NV5jU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYX8X20M7z30Ss
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 06:53:15 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso676461f8f.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744318393; x=1744923193; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6Y88nCpCByqh57KqElWwwc/R0n7e7vwOFEt/7pFPgk=;
        b=Du0NV5jU/06k5T4xfUpFlkOmO6ygYlHJlOQEiMsrepfwFU0cM+l8Ofwe6ua7zzAKUr
         1FFXZHjSodbHULHP1s+D96J0MUJHDMfV0GMfSw7Mm0U0Cf+fOkJMy0cLqh7PNi6th+u0
         /ckYtHFks+7R83aUuGpF/f4HY3v28FZ5sDbRUeA9K1HRtzLk2yMxkePC+6oMiE1RiHsa
         MbBl+9k4QXvK9aWdBpnKJWkwvBk+O/b6xFzMhlpDfTIaHc+dRViK8cULAWwqryxavOz9
         0Hqw3Jhq+56A9MPsDs/mjJn6tfiWKN4BZWkW18HK8lQH4WYwkBFfNqFLLdNyUFgYjPDm
         iHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744318393; x=1744923193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6Y88nCpCByqh57KqElWwwc/R0n7e7vwOFEt/7pFPgk=;
        b=XiDcEFXXNVBTFiObxRbITCdUA2/uH/Tm7rScbrS5ZleYYPOwY2PLdPjGvakYY5fQbA
         aLLQMKoH+qOdWVeaXR4XFyEnbS6sGWFcmY6q4WP1kaYe/lrUWmmGm+9hyf+HdZaetesU
         +xgzthVT0sS7qc0r2wkd/H6w6kfoMmFnmymKIPglSyNy4RO/De2PUUVUsRw8f545TRwX
         pU3Clov1c8L63O0QMKHabT2HZbg5VYm4NqRNHlx2y3gdBhlZPPI5459IOwvQWCzIAy6U
         wDjEq6QWYIRuuRLQnaK9LpI6ZbHeCmQ4slmBEQDvx87jO38Fuvyk2hMcu+6S+cfEeGII
         6ZHA==
X-Gm-Message-State: AOJu0YyRewr93bjg+L7gIib4gY22cJ2FRY6wjW0uglezC+Ar2oSYVv0/
	WIZ6T4xB/kzFKy43jk4c1w/ibzsvyMt6SZlKfyrv6gbBXoEerACuSBexkw==
X-Gm-Gg: ASbGnctcB6ehpw1H8WEY0s4Cc9NGYEomiCQ+0ZmyMJvRKwDIYsLZwmj6EOjeaJ6CMrG
	DQ0OxQ7BpSLrvFrEg4NMXjMiHRr2udqVujPxABx8QmW9a1g+QN3PYtUNvbjz/D99bR4xFjtI6OP
	CD2e/U1gi6Q8rLGyREI/BoPAyvMKYX8Y5i3DHcuuOn9Ykn/sgE1I8t+dFZ80K5N7nApVSURLHM/
	alLooSZRvVZeDwA4ps71HDptaRRXwuEPkr+jqHDIbbIAICIbpi6HWivsGxwA+33KewiB4ZZSZ2D
	WlpArVhswQnbzJXijmt47zwsQVVNPRefT65rFyjaoakgQR4eovMW8e9dTqkVKal6BAAXXlCeclk
	oD3I=
X-Google-Smtp-Source: AGHT+IGTUslxEkhrCt7bHXWPpF20wfuH27sp+wfINxWQbT5zpiMtJ8L7zM+H+yeYwm3JIewxAAojPw==
X-Received: by 2002:a05:6000:18ac:b0:391:4873:7940 with SMTP id ffacd0b85a97d-39eaaed57ecmr79391f8f.54.1744318392664;
        Thu, 10 Apr 2025 13:53:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2c84sm62589215e9.11.2025.04.10.13.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 13:53:11 -0700 (PDT)
Date: Thu, 10 Apr 2025 21:53:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] erofs: add __packed annotation to union(__le16..)
Message-ID: <20250410215305.0c919e78@pumpkin>
In-Reply-To: <7af3e868-04cb-47b1-a81b-651be3756ec5@linux.alibaba.com>
References: <20250408114448.4040220-1-hsiangkao@linux.alibaba.com>
	<20250409195222.4cadc368@pumpkin>
	<7af3e868-04cb-47b1-a81b-651be3756ec5@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 10 Apr 2025 07:56:45 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi David,
> 
> On 2025/4/10 02:52, David Laight wrote:
> > On Tue,  8 Apr 2025 19:44:47 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> >> I'm unsure why they aren't 2 bytes in size only in arm-linux-gnueabi.  
> > 
> > IIRC one of the arm ABI aligns structures on 32 bit boundaries.  
> 
> Thanks for your reply, but I'm not sure if it's the issue.

Twas a guess, the fragment in the patch doesn't look as though it
will add padding.

All tests I've tried generate a 2 byte union.
But there might be something odd about the definition of __le16.

Or the compiler is actually broken!

> 
> >   
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/r/202504051202.DS7QIknJ-lkp@intel.com
> >> Fixes: 61ba89b57905 ("erofs: add 48-bit block addressing on-disk support")
> >> Fixes: efb2aef569b3 ("erofs: add encoded extent on-disk definition")
> >> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> >> ---
> >>   fs/erofs/erofs_fs.h | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> >> index 61a5ee11f187..94bf636776b0 100644
> >> --- a/fs/erofs/erofs_fs.h
> >> +++ b/fs/erofs/erofs_fs.h
> >> @@ -56,7 +56,7 @@ struct erofs_super_block {
> >>   	union {
> >>   		__le16 rootnid_2b;	/* nid of root directory */
> >>   		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
> >> -	} rb;
> >> +	} __packed rb;
> >>   	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
> >>   	__le64 epoch;		/* base seconds used for compact inodes */
> >>   	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
> >> @@ -148,7 +148,7 @@ union erofs_inode_i_nb {
> >>   	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
> >>   	__le16 blocks_hi;	/* total blocks count MSB */
> >>   	__le16 startblk_hi;	/* starting block number MSB */
> >> -};
> >> +} __packed;  
> > 
> > That shouldn't be necessary and will kill performance on some systems.
> > The 'packed' on the member should be enough to reduce the size.  
> 
> It cannot be resolved by the following diff:
> 
> diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> index 94bf636776b0..1f6233dfdcb0 100644
> --- a/fs/erofs/erofs_fs.h
> +++ b/fs/erofs/erofs_fs.h
> @@ -148,14 +148,14 @@ union erofs_inode_i_nb {
>          __le16 nlink;           /* if EROFS_I_NLINK_1_BIT is unset */
>          __le16 blocks_hi;       /* total blocks count MSB */
>          __le16 startblk_hi;     /* starting block number MSB */
> -} __packed;
> +};
> 
>   /* 32-byte reduced form of an ondisk inode */
>   struct erofs_inode_compact {
>          __le16 i_format;        /* inode format hints */
>          __le16 i_xattr_icount;
>          __le16 i_mode;
> -       union erofs_inode_i_nb i_nb;
> +       union erofs_inode_i_nb i_nb __packed;
>          __le32 i_size;
>          __le32 i_mtime;
>          union erofs_inode_i_u i_u;
> @@ -171,7 +171,7 @@ struct erofs_inode_extended {
>          __le16 i_format;        /* inode format hints */
>          __le16 i_xattr_icount;
>          __le16 i_mode;
> -       union erofs_inode_i_nb i_nb;
> +       union erofs_inode_i_nb i_nb __packed;
>          __le64 i_size;
>          union erofs_inode_i_u i_u;
> 
> I doesn't work and will report
> 
> In file included from <command-line>:
> In function 'erofs_check_ondisk_layout_definitions',
>      inlined from 'erofs_module_init' at ../fs/erofs/super.c:817:2:
> ./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct erofs_inode_compact) != 32
>    542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |

Try with just __packed __aligned(2) on the union definition.
That should overcome whatever brain-damage is causing the larger alignment,

> 
> > 
> > I'd add a compile assert (of some form) on the size of the structure.  
> 
> you mean
> 
> @@ -435,6 +435,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
>          };
> 
>          BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
> +       BUILD_BUG_ON(sizeof(union erofs_inode_i_nb) != 2);
>          BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);

I'm sure there is one that you can put in the .h file itself.
Might have to be Static_assert().

> 
> ?
> 
> 
> ./../include/linux/compiler_types.h:542:38: error: call to '__compiletime_assert_332' declared with attribute error: BUILD_BUG_ON failed: sizeof(union erofs_inode_i_nb) != 2
>    542 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                      ^
> 
> That doesn't work too.

That it the root of the problem.
I'd check with just a 'short' rather than the __le16.

	David



> 
> Thanks,
> Gao Xiang


