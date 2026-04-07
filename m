Return-Path: <linux-erofs+bounces-3219-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIHcF/5Y1WmC5AcAu9opvQ
	(envelope-from <linux-erofs+bounces-3219-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 21:20:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3133B35C0
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 21:20:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqwyJ31RZz2ydq;
	Wed, 08 Apr 2026 05:20:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775589624;
	cv=pass; b=BQHkaVA7QG2zmB2RTeqkMpQQGx0cpg2JDBOzgCdepO9RFDyldFlBgyPEqsxiZ64zmRqaEAgUSftBSEbOedWya2LwiVL+g67INiKjFfhdaraIgLjyXjsoXvESG3vDW1efDKC7H1x2DRDL4x9jVnbOFZRbcN1Y6ZICC41sdG87ZdjZ0et3FNlBYzuHvusMHhseBW8Q64T+Djb2v44qqMONy7m3aTHY8MMJk2sudcjVK7vjZ5QHUv0MkVRh6Ie5xSRuXAEKj0jc7LeL/VOEqRjk1OgHL7BJAh6I1OK82cWuthm03TWg0rn43ZqZzyIxJnXTOOdASniGXR1MySyxNx7xcg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775589624; c=relaxed/relaxed;
	bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6FlBaNJIxdh/eIRhRX1ZEA+UR+dqezC1fOz38lezyhqVSMndKqbd2lGYQVG51+ltcCCz7mRQq+VIrjmXGIffAtZu1T1oFgPM+16UC8cvvn2bTw/jJKCan1zUgDhmMmFEsjDBLT/WK+ynheZfqL69MscrXrlLoztpdbj944GNERFhqyZDsO50drZQZ5olGbs3IsysjaQxRGpADAyLLDgNbA8ZmszVJKqY7d0VHmjRmC0iPCdCNkLjcGzcbjsqYnENVvKmCtx3tk3yqa4BDoQ6lVClimLGcdfCwZ3nT3wQqMsIiKmUohipXDYUXakEq0Yc4AxZ2QyZaTzZqeJWvOy/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nilMkzvb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nilMkzvb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqwyG467cz2xQB
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 05:20:21 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-35c206f0481so5208443a91.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 12:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775589618; cv=none;
        d=google.com; s=arc-20240605;
        b=BnpbNSWewJsSGpHOQBp/VUAAv9TFIRX3ZcclKCBjknM64UkFzB+5oUG/bagfvP0PU6
         t4z7rP+bVNuBgcdqt7nRhHNRQb4APXbVBi7rSqYQ278YoRdjKfJS+4B3R9xJTexC7QGK
         QeZPgAH6+1/nlyfixWgX9X+5XBXQNg8I7w1XBysCBKKaq+qRwcUNr5Jffi32UZBSH3j8
         Qk4YTX+jruO4kIRm1+PBkROGK0cZMyvd7eynlZxwJrOs7ZRmAfq5FUfugVYeP+SclGzZ
         ClmXNJFaSxvI+QMbDMF5YP+cdSRDzpEIf8EhSalxkVGnpuifUzlh3iF+CY16wHJzvhxM
         asCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        fh=hhaecV6+d69ldRkpReAa576/gTXNdB6imP0V+Oh1XCs=;
        b=eHLLNYaX2aituTTtw9Nb0MaVhjRojEKtHlOCmCDF3o3v+wF0yaclhDXilbQwKWbram
         zJHL2o6l8fiJC2og+Z+QtCmKGUe0tzTJeSLLYY/OB9kjUmfkI+6PlPHfRIsdBd3cfv0l
         KVtBHpNGLUQ8DMSxoFQXOlbRzeBmvrIM3aRBfLWse3KcUvqEQsunnktfT9wFSgnupmSk
         Hkehg4z/esMqAxXKNmqurxODaLqjnx9G+ZWoStQTJxDESLnkEJHRzQ5XgqytNdDTZLuo
         nb8zHL9CGRGBSZORSIurzsdHMCZgrxoziGo2y5rU67LVJfw4ra26ZwzYMid4RZ3haXyC
         dfYA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775589618; x=1776194418; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=nilMkzvbzHdwWlt/kPHKqKwAIH3RfZcdVubxnc6BGehULJlwlu0T92QeyW4Xty4iAy
         E2nRydE4rq7MKz6cSRIz2HSUcCWDqXHN0G+0xeSmgR2GuAnVf4TF3LaRDUrIEen3Vkg4
         AsBlmFaIXnT3tUD1qilcliDeovP4gDKAbGevbHN2VX5D+QkLPbM0aLrh3T5GsSuhiir8
         AVS9pEjv+4tZtnddI4fP/RWWZMb8stO/i740A9fpXJsStqYO+d8H4TdZ5CzmpA3VxMCu
         qtbCExD/d5/tU10PU5PNVQnvqfBhqOZ9DhfAcoYTUE7eE7AMCX65QtO0tJE6kWkKllqn
         68SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775589618; x=1776194418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvCMx9MBtYrViWX1Qz0ZJHbJw9R+8QQ6ywXBNqXTjw0=;
        b=VFVLyqd8IQ4OTLVzdCHVuIrRWLPfcpsxZJ8pOCGgXj7RyfkBPLRn9TWZgABfzRKRo6
         YOtktqwecJDoUrCnLPE5f2NNJ+BiapdqiGkoafHomcWz5yWBWsiJZecZGZj6ZhF+Sonr
         gWxWEQVYB189cJEh0eQStN1DeZWFQsLBHNZDuFAaewXWsdoDc/gbyvPobAqbYFvJORI5
         q63+a6TuuAhuCNKOW41TY9LvvenQRz4LWzRRDg8VqVIb3xa37zksg4bqFBid7rImNBJE
         /QIKVWaua8V/j9q/Jk53VCzVoJw3npQUCU3T+hy8jcijjaBy/lDxC2OjQOKVaO2DvgZh
         G4eA==
X-Forwarded-Encrypted: i=1; AJvYcCU9oSrvsmix2P6Gnq0hmWAiiVgyq9xu7YEgphRSyp94rP9v1ABUMgz7y8OApGGvDcTKt8X3AlrHlH044g==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxlrNo72iv0mSQDkAEZwcFnxMdYg9PZyMbAwvCyEQKRcnD1VxmU
	mkQERoL7qZd5hBy68x+gJt7V5vi1VxK+u2YoDcMwKSlk874uQ+e+AMHSsqcYApWgsem1AXi312f
	EOZ1yl4KN9tE0CnmwrgjN7zOtc2s4aV4=
X-Gm-Gg: AeBDieuA27HjMxYL/ONj5Wzx0B7VLengZRZFMI5dUr8l8IF/iZm4uJMuySvdx3cIaz4
	bhMqitNNz9ryiK139qZNFDkMjuXo2jKgwQhFFh4Wwrbyofefqjma3Ham5yHNN5Yr535ydfVmlFQ
	jtmgUFSd/X+tnml0OA9N3JTywM8vtU9n7pg9UfA7mPgvJUHbdd9RG90uo4YciL+6yDRIBfAPtxU
	uY2FGQ5hLwCKgrXB+x5a26fulDqrGD888Y7ivfddVfxT/oOaZuElLgVcOWCVUDbd3CV8VvKuLip
	683RfRw=
X-Received: by 2002:a17:90b:3d4d:b0:35b:aca5:db39 with SMTP id
 98e67ed59e1d1-35de67ee6bemr17005316a91.9.1775589618190; Tue, 07 Apr 2026
 12:20:18 -0700 (PDT)
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
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com> <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
In-Reply-To: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 15:20:06 -0400
X-Gm-Features: AQROBzC7o3Va4ubfSL9DMqzx-1hfP9_BswdLqwBtMsXc3haoHViWO4Xh57-I6OU
Message-ID: <CAEjxPJ62=0v9QYJ6s0DrwRp4WZna8f9wnuM_DUUNrcz2dd_kog@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lists.ozlabs.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3219-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:omosnace@redhat.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[stephensmalleywork@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5D3133B35C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 10:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > The existing SELinux security model for overlayfs is to allow access =
if
> > > the current task is able to access the top level file (the "user" fil=
e)
> > > and the mounter's credentials are sufficient to access the lower
> > > level file (the "backing" file).  Unfortunately, the current code doe=
s
> > > not properly enforce these access controls for both mmap() and mprote=
ct()
> > > operations on overlayfs filesystems.
> > >
> > > This patch makes use of the newly created security_mmap_backing_file(=
)
> > > LSM hook to provide the missing backing file enforcement for mmap()
> > > operations, and leverages the backing file API and new LSM blob to
> > > provide the necessary information to properly enforce the mprotect()
> > > access controls.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Do you have tests for these changes showing the before and after (i.e.
> > failing without your patches, passing with them)? I tried running an
> > earlier set from Ondrej but they failed.
>
> A few months ago I sent you and Ondrej some feedback on those early
> tests from Ondrej, but yes, I also had problems with Ondrej's tests.
> I've been using a hacked up combination of the existing tests, some of
> Ondrej's additions, and an additional debug/test patch to ensure the
> labeling is correct.  It's far from ideal, but I didn't invest time in
> test development as I assumed Ondrej would continue his efforts there
> (unfortunately it doesn't appear that he has?), and I wanted to focus
> on getting a solution as soon as possible for obvious reasons.

Ok, I'm happy to look at even unpolished tests - just want something I
can use to exercise the before and after states.

