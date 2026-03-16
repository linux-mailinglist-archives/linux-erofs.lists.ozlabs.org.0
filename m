Return-Path: <linux-erofs+bounces-2771-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNOGOFJ9uGmVewEAu9opvQ
	(envelope-from <linux-erofs+bounces-2771-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:59:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1702A1378
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 22:59:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZTXH4kMdz2xb3;
	Tue, 17 Mar 2026 08:59:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773698383;
	cv=pass; b=KmV+GPx24E4HXRgCev4mbxir0j0qqpi3svvBUaahT76UBnhntg11FRm+hyLhuCgL7NjA/3N36RLZWVQUStowCNzapcRaeuGKSGx1o+Bg5t04/QUWG4Q+TZqwj1t9ZlNZ6mTpUNyJrZYVbJ9dj3tXRQvtXpItREOCQohk0hYNXkgIjW5FoCxA72FsO9lhFQavAdpj15iZFW5r/phn4WgviKn3BXFa5QvYESGFGolIxvfmEVgi7nD9o+2g4n3ztyr2eeaAXq5Si5pSKK5J9eGSB82IWMBY/FNorocpew3jpqTEiMPMiJ4j3YaJ2Ae7qnCsFsxlJ9gqHt0VuSgv2tsiJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773698383; c=relaxed/relaxed;
	bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmjnZwsGBxPPMyiPJeBh/WrbgLfmYcWLTCD8LdPLrWnId/puFGO9nK1HedBaVzSba35FQyioamfiJTr9SY013H30wHHT2IrIGuiVs3RLNOX7rzo3gLxQlwhI+0ReaWinrI1lLoMtBH0oAP/XMp41a2bCAhBs79Yauobm43yBjx41ORqXppso0Xx29/CV/2aqxhnD9dvPk/hwOlqAG9vj3W3Xb9AWUhXM2lJuocX+8DOY7+oYFUDbDAIJ9OgNSss/hNVwGg0SS1wbAySEO8Za8g1w6Gk17SvZlFBvtSJZdMsZ2cEdSniJAIO4xzCNEmvALtkWT7SiZ2hIdk3aDSQmUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=aNDnu2a8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=aNDnu2a8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZTXG2wlFz2xS3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:59:42 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35a02f3b8feso2063466a91.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 14:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773698380; cv=none;
        d=google.com; s=arc-20240605;
        b=EGTUoAVFicC29I8wg+OinTv3WSOiPkjJNL+jarmMdT2myIbMswHsCK/nKUG7Uk2MbX
         MZ+QgApNZOGNnf02eIC4nDO29JiHK428KmZzhm8GR0yj6yTnx34Pa1OhFIlIR+cnaPMr
         uejpSjeteF+3mNHcClNWoG0bvLhGthzsxPttM49VLrcwgxjbePzcBn2gS6JWIKG9aR5v
         qW8Bpgon2fGkx3j/CRL0IlI318q9XVGDhLwdBjQHXzkjh0EdOsyPXFEAxfpdAxIiY5jJ
         ozOHxZWf3mANiJbZbywtnN2Vo7cps4Njgyc5lc0WKvlLV7Ttork5L/IGLMCOVUb3obBv
         jT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        fh=hBR2i+l+m5SHiBwd3eUTNuwKhMM1wylvu3ny/MK+JDs=;
        b=kwzGqX0iFQ5HVC6wR36ZUsp5UMOtsbmNm6N5jAAxcYXG+2DN7jRtwThUAUlFwy8wwB
         3dp6cTihwf+G6AuTJUb7iNvv0xCj2yujl/lpFK2bQMKD6M+rQ3JWzCKaoOgFKsfpKnmt
         Gy6fofYsFJEARVo8NR+T0ZgrNrvWRqZvKQu3NJuaTKUWBzHPcHs93qS3oocQT89pxxZP
         Mwsh/lab7uNcIn31VsRTbeL25VUcneWTz8K2XzTGpO+BdwY89S1cVwoBa/p8KGlQnU08
         Cd3bLw39cF35Saw0rtpMoizCBHLTacfzpZMgw8f+E5Q3lIWANUBGF1Z9QOnow6mceCpw
         7VjQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773698380; x=1774303180; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=aNDnu2a8qb2ONL9FV1ZGYp/JYb0raa0lRufu91F5kF4hWFCFgKMLRtvqHjZleVh31+
         Qm6vKDmt/6v4DJdM+iSzzWR6y61WD6sH23GQC7gKkz9jT444O1fGTl6D/JKdyoD+Iwad
         pRqG7b0YJRONUpQzQ5WpZiY+dZQLciEARR6FoZU1pMJqj199RoX+CPurp5cQuiunkqDh
         1FwmrezpguuhXI1c3jL9G0TFHZOklL+NZyNqsDu+eot9/Czc8rB/+Krt5W1LfVYEs6Rs
         MSQRxfKHwpNSwweMXBqvWAaZ7Pw4O8Snfub+u3FvxqV15tI5yhsw5qKCMiM9LxryH361
         AnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698380; x=1774303180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=baaz05vN46ySUjc5nMXVfWNyK0uut6ez46xl4bwWy/4=;
        b=JBo8GtkRHLY8k7P8SzCGpCYI40x0vBlkd6kIBjMqLiXWS3y4ZzNNjWUIUonReZg+JK
         wwMAMRhcdzb4VNWCcxrvUn6ha+gAflQkDq6h9eYBNoaxEQh0FuZZ8MvCO1g/yqCIkpm/
         ZL0K467UOS29L2EvrjaMBOXA1J7YbvUWufwWQk34jZlUn8yabcAfX74F+IEqNOVOUWFH
         iAYKTKZ7LkGXM5wA1+9FOs7IK+r9zW5M3JaMgjfPKHuFD2QlETyGcsxv4yyXWRWlnjSs
         2hjLvoNgRDPCNVqMKxRyGAjujM5ZWAEVmVqlgzGFYhNiDZNuG8BGnO9hiiOj5V0YyAIL
         B7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFPtkA6UIwWOH7/hy0U0Lnd89BiNgBiAOL1Ks6JFZG/hhA+6NGz4Tk5tmRDa/80mOjq6596Oi3fRWp7g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjqBWpImB4i/Xm3XD9syQFIWx7ZfzQCpARuHRT5s1lSpoFKO06
	XWyHpQRZ7sZ3a2v02vT2A2ACFXRbyzZt4eJBdWEEWyrsgukkhR+9MD4x2NQLDVnmGqJgrtQXej8
	PH2Bi9NQQJfPvTaQ11KjjNhefR7zBnrzr0IMuayM2
X-Gm-Gg: ATEYQzzpOA7XIBQXisxP6tMIi4jXlISmRigW1iNxHLgYKFRszoSKiKNBm1wAqJrF7vB
	zN42dd5/nzIXN5v33Za2tqF5sQM2GZtoBj0rW54JfNvZ72kjahPwZvRg9An2MfwMhn0WHE0KyOB
	xmrd4v8rtQRMzXbJMHumVCy39O88yYMIhFkNr0l7XvBspvTZrpzNiktkCFjESvI1ZdzAbTHYS/L
	vIO/7eW/n3th+cxTvG/fW0J7ZJ5LONRgcBiOdixQgVdZCMDeXwoXSR3k0wAGRtxcI1qoEM/VeRi
	3q+5xCU=
X-Received: by 2002:a17:90a:d60c:b0:34a:9d9a:3f67 with SMTP id
 98e67ed59e1d1-35a22081eb3mr12428760a91.33.1773698380402; Mon, 16 Mar 2026
 14:59:40 -0700 (PDT)
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
References: <20260316213606.374109-5-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-5-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 17:59:28 -0400
X-Gm-Features: AaiRm50Q0DM9xRE6xrYOCEeiOu8cKoO8ieFIUmC4mYeVLGbPolGQ90N17nL41QA
Message-ID: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-2771-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0A1702A1378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing mmap() and mprotect() LSM access control points for the
> overlayfs filesystem are incomplete in that they do not cover both the
> user and backing files.  This patchset corrects this through the addition
> of a new backing file specific LSM hook, security_mmap_backing_file(),
> a new user path file associated with a backing file that can be used by
> LSMs in the security_file_mprotect() code path, and the associated
> SELinux code changes.
>
> The security_mmap_backing_file() hook is intended to allow LSMs to apply
> access controls on mmap() operations accessing a backing file, similar to
> the security_mmap_file() for user files.  Due to the details around the
> accesses and the desire to distinguish between the two types of accesses,
> a new LSM hook was needed.  More information on this new hook can be
> found in the associated patch.
>
> The new user path file replaces the existing user path stored in the
> backing file.  This change was necessary to support LSM based access
> controls in the mprotect() code path where only one file is accessible
> via the vma->vm_file field.  Unfortunately, storing a reference to the
> user file inside the backing file does not work due to the cyclic
> ref counting so a stand-in was necessary, the new user O_PATH file.
> This new O_PATH file is intended to be representative of the original
> user file and can be used by LSMs to make access control decisions based
> on both the backing and user files.
>
> The SELinux changes in this patchset involve making use of the new
> security_mmap_backing_file() hook and updating the existing mprotect()
> access controls to take into account both the backing and user files.
> These changes preserve the existing SELinux approach of allowing access
> on overlayfs files if the current task has the necessary rights to the
> user file and the mounting process has the necessary rights to the
> underlying backing file.
>
> --
> Amir Goldstein (1):
>       backing_file: store user_path_file
>
> Paul Moore (2):
>       lsm: add the security_mmap_backing_file() hook
>       selinux: fix overlayfs mmap() and mprotect() access checks
>
>  fs/backing-file.c             |   28 +++++---
>  fs/erofs/ishare.c             |   12 ++-
>  fs/file_table.c               |   53 +++++++++++++---
>  fs/fuse/passthrough.c         |    3
>  fs/internal.h                 |    5 -
>  fs/overlayfs/dir.c            |    3
>  fs/overlayfs/file.c           |    1
>  include/linux/backing-file.h  |   29 ++++++++-
>  include/linux/file_ref.h      |   10 ---
>  include/linux/lsm_audit.h     |    2
>  include/linux/lsm_hook_defs.h |    2
>  include/linux/security.h      |   10 +++
>  security/security.c           |   25 +++++++
>  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
>  14 files changed, 231 insertions(+), 60 deletions(-)

Due to the nature of the issue, I'm going to merge this into
lsm/stable-7.0 in a few moments so the changes can get some testing in
linux-next with the idea of sending this up to Linus' later in the
week.  If anyone has any concerns over this patchset, please let me
know as soon as possible.

--=20
paul-moore.com

