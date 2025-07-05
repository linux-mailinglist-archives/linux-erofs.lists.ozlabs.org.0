Return-Path: <linux-erofs+bounces-533-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F49AFA059
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 15:53:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZBmM4Yxrz2y06;
	Sat,  5 Jul 2025 23:53:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751723603;
	cv=none; b=SKSc6NEpvnZW+HoqSXQanZWn9m157bTLxyCLNTrrI7NlvBR46TyP23oYSv4u8ymy4IF6CqarmmP+WzSWpBiQmO6ul74gZAbFUZeIy6axaPmnAdvT2pkcN0AzA4R5XLD1rUXVHpCHpYQ4Qm+JyMBUBQIZ9Dd7jVDgL7gy+YZd6XF2Fw5flahxfsO+O0pJAS5eDsKNj2fUcsCHFdApP8esGK1IMXG2qDCjf27AX4dTlfAjREwBeZRjCAGv3C1cLtp12ag5qlIddqC/cHMlbol3QO6uL6LcC6D2DkzCKMYzkTOG89FKhr38jpPPMmKBUiT20StSN4jhQd0CaAPFOa+Pzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751723603; c=relaxed/relaxed;
	bh=hB9cl2ndxuhttgfkfk7BGBfUA2vcqkP/Zn0IA7GwdQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFF5uw0CglBcl5kErnninmVdLUIM/84nt7XCMpSZLVh02KOUNFxUl0fDYFDsXVlnlawiHu8qe3XD8xXvLVvz3hHCyaHjyr75K5amCH5HwVZ8qSsiPCajikyNnl2SmzCxTDMXe90fMA6bTmKHqeJ2R1gqIUOwO/xHli+iV/8PQB4goq2+wrbbiK+Lh6cPSCBLafv/MEZyN9WOE1riG4+8BxewQnCw892njHYEG0LKdzCFlI9EfeV1LnogOcvB4sRrQxf+0JBMSvizuhlnJKm8UJQbq9dEDHG6jKtMgr2c7h4KYKSgKc1nOU2QK2bETqriLilWXiA45P7jGMpzI6ejnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lEVOC8sx; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lEVOC8sx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZBmK4QzSz2xlL
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 23:53:21 +1000 (AEST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-adfb562266cso266703366b.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 05 Jul 2025 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751723595; x=1752328395; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB9cl2ndxuhttgfkfk7BGBfUA2vcqkP/Zn0IA7GwdQ4=;
        b=lEVOC8sxZ7q1HBifQAH0AM9XRvBN0WUY/g0IlA+boxAsnA9kH1c1K4MNX2dtbY0dNL
         khqezt9bQ5tT+wYsGW9Ht/DDCLjWR4OHFO31iA9nDBOfzdBaoseyLxEZM/Qe95KwfTEd
         +x04BAywasSPOWyZxlvcNbuhhdFy1ZtRhse/VMEGgDg7Zv1Ri6S/mOYDj3EMneLKjLIQ
         Car/Vy8+KMssfAai33YZgLIF48jgZ4m8FDRc1H5OJONGpXX8zuNPxflLdr+irhevc2y2
         EJP9WHThBoXiqjJRwtTGjn3YBtCYxdwBHJG0fmiwMmcWJkc8B8kAWz3oaOe7c5+ZDRbA
         suIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751723595; x=1752328395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB9cl2ndxuhttgfkfk7BGBfUA2vcqkP/Zn0IA7GwdQ4=;
        b=Sk2xWpOOulm9UtMCi90TvgXYbYcZx65cCzFmA5teFZ7Xvh7ZdGk8uovyt8oSndn25r
         iHfj0Eb2mCm/vZ60hqwUf6rMXyZhmIpcziX2y4N53sCsOuhMiRsahO5Lmg7Oaml3b9ia
         8Lg8daLCnoMk3zsR5YwOKM5FEfkPwrFvhz5h5PTNqwSBOYemNfoXRPPe40LC+u+kfbCn
         4KpmhLLS/IdEbIfDhIHh6TE5iS5nMFKecab4kXu/yAWbQrkXRw4HdT9cZzQDwDtZvMbl
         SGA0agJbiKfsq+TfD+LKIE1mE1NUK4wxuQWasdlQ/SB5mv+BAqjHvZkpdyOXds+V76Da
         VCKA==
X-Forwarded-Encrypted: i=1; AJvYcCX74gkcSho7wXFyJj7Gzaa7a1jLPpGTVDT3Lg4h6jQbstzUARFj2fq88By03Ni7N0wIyeQGhICLVKZY6Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwUNw+O2t21YUTfLe+1a4Re2CIMDkJQ0iV32yQKFyGpcLcKXkeX
	PKRCRsQkYVeZWgREWawNNl8X78IyMFQoYHvpLLZHwJzbh+2uF35EsoAFHRIaFKAnnVHA1OnD1Ft
	50WPB9J5i1vQ8Y47F/jLqb6dL0sKd11g=
X-Gm-Gg: ASbGncuPeBmPf7YXp/b8wCp5I/15lGDCQxqC7HF7mhSSK/4EcXdZeKGe6WMqNbwq00Y
	9LckHlLRtZhHpO57EvWAugCMk3PA7GXEgvaAumqvsms7/yd3JNI8AXF4yABRSq/x7rBIdrozTGq
	kkjAsqBdDtJ0elw8DIJ4rW0BpIOfO+49IVK3D2CGECJAo=
X-Google-Smtp-Source: AGHT+IHtlfZ2H7A5G2bRRezKtXnYu+jqYkKVxvOnufYPfAqLEpGamH4eo+SjXwTwj7qiPmPH6xWz5eoUoPVOLZubnZc=
X-Received: by 2002:a17:907:60d5:b0:ae0:4410:47e3 with SMTP id
 a640c23a62f3a-ae4108c9325mr229202766b.51.1751723594639; Sat, 05 Jul 2025
 06:53:14 -0700 (PDT)
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
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org> <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
 <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com>
 <33817204-2455-4b8b-940e-072fad58191d@linux.alibaba.com> <CAOQ4uxjFcw7+w4jfjRKZRDitaXmgK1WhFbidPUFjXFt_6Kew5A@mail.gmail.com>
 <91cf62b5-45d5-40b6-b4e4-ec768f850361@linux.alibaba.com>
In-Reply-To: <91cf62b5-45d5-40b6-b4e4-ec768f850361@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Jul 2025 15:53:03 +0200
X-Gm-Features: Ac12FXx6Aip7fdYwSrhLhb_30JIiPcWycRy-rZOHDPH2K49IahlPwyRxiXyneYI
Message-ID: <CAOQ4uxi3WK77ezJiYt+evBwh1TH0OTUSNw+CD6e2VEdy_e2pew@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Sat, Jul 5, 2025 at 2:53=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2025/7/5 20:34, Amir Goldstein wrote:
> > On Sat, Jul 5, 2025 at 12:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >> Hi Amir,
> >>
> >> On 2025/7/5 16:25, Amir Goldstein wrote:
> >>
> >> ...
> >>
> >>>
> >>> 2. When is it ok to use the backing_file helpers?
> >>>
> >>> The current patch allocates a struct file with
> >>> alloc_file_pseudo() and not a struct backing_file,
> >>> so using the backing_file helpers is going to be awkward and
> >>> misleading and I think in this case it will we wize to refrain
> >>> from using a local var name backing_file.
> >>>
> >>> The thing that you need to ask yourself is do you want
> >>> backing_file_set_user_path() for the erofs shared inode.
> >>
> >> Yes, agreed, that should be improved as you said.
> >>
> >>>
> >>> That means, what do you want users to see when they
> >>> look at /proc/self/map_files symlinks.
> >>>
> >>> With the current patch set I believe they will see a symlink to
> >>> something like "[erofs_pcs_f]" for any mapped file
> >>> which is somewhat odd.
> >>
> >> Agreed.
> >>
> >>>
> >>> I think it would have been nice if users saw something like
> >>> "[erofs_pcs_md5digest:XXXXXXX]"
> >>
> >> But if we use `overlay.metacopy` for example, it's not
> >> a string anymore. IOWs, I'd like to support binary
> >> footprint too.
> >>
> >> And I tend to avoid md5 calcuation or something in
> >> the kernel.  The kernel just uses footprint xattrs
> >> instead.
> >>
> >>> IMO, making the page cache dedupe visible in map_files is
> >>> a very nice feature.
> >>>> Overlayfs took the approach that users are expecting to see
> >>> the actual path of the (non-anonymous) file that they mapped
> >>> when looking at map_files symlinks.
> >>> If you do not display the path to erofs mount in map_files,
> >>> then lsof will not be able to blame a process with mapped files
> >>> as the reason for keeping erofs mount busy.
> >>
> >> I think users should see `the actual path` rather than
> >> "[erofs_pcs_xxxxx]" too, but I don't have any chance to
> >> check this part yet.
> >>
> >> If it's possible for overlayfs, I guess it's possible for
> >> erofs page cache sharing, maybe?
> >>
> >
> > Yes, I am sorry if that wasn't clear.
> > If you want the map_files to show the user mapped file's path,
> > you can use the backing_file helpers and more specifically
> > backing_file_open() and all should work as in overlayfs.
>
> Yep, makes sense, and a quick look I think we should leverage
> `file_real_path()` to reveal the user-shown file's path.
>
> But I also think erofs don't need every backingfile infra as
> you said we don't need to override_creds and call in the
> underlay fs but that use erofs io directly instead.
>

True.

> >
> > Obviously, you'd need to wrap the back_file helper with
> > erofs specific logic, such as don't allow dio and such.
>
> I think maybe only `struct backing_file` is really needed
> to support the user mapped file's path.
>
> Other thing it seems a overkill to use `fs/backing-file.c`
> for inode page cache use cases.

True.

>
> Also, maybe I misunderstand your point. I think DIO can
> work too, .read_iter() should be per-sb and we may just
> use the original DIO logic and pass down iocb and iov etc?
> Since only mmap i/o needs to be handled via anon inodes.
>

The title of the patch set is page cache sharing
and DIO has nothing to do with page cache so I thought it
wasn't relevant.

If the inodes are also sharing the backing disk blocks,
then I guess you can do dio either on the shared inode
or the original inode, but it doesn't matter much.

I meant that the only part of backing_file_read_iter()
for which you may want to consider the helper is the aio
part, but since aio is only for directo io, I think there is
no real benefit of erofs to use the helper.

Thanks,
Amir.

