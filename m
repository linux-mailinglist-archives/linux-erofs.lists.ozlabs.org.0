Return-Path: <linux-erofs+bounces-3216-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePK1ICgW1Wm30AcAu9opvQ
	(envelope-from <linux-erofs+bounces-3216-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 16:35:20 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A253F3B01EE
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 16:35:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqpdK2KDsz2yZ3;
	Wed, 08 Apr 2026 00:35:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775572517;
	cv=pass; b=DcCLR9ft7oFJD/2lS6uyuPBMBozpa890PE9UialKjWSODsVALbJ0VH9jjhRZAPJzqiQYe7hJGqixcJzFC3uIGs6I2GQoRCZRZjxTkbwjsxVUJ+9TniMcaavGn/AyH05q3qm2fpqaffeXVrZGa+WANR4PE4NMs0VcxGGqYfuw+qbPEiBKYbDJhxBwLGnMMKjfx47bEmgVlXNFRjXVelsIibMYmzvHgm6IHnPwsaY91hGJVbKJDwj2hCAqcv9jSFcLaltrqeyzWYyhBb0QD6u8FEkw2upBJcCyR89UCRfPO+bkJPsBKQbxjinE9XdJdZQC6JI/XJa1uqIFhgHVSdte3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775572517; c=relaxed/relaxed;
	bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nihYDCX1FejWFMpYIWZ+WRXETMmZZP4wWnyhQCpuQ+i2V0DB5aMUV2yxDzt9KaSIb+qyoOTmm4pFDOjzb4ek8OnaWJJpu70rzB98uhQz83mil+cOlKwucOaQxSgMKhyUkcUA25N6q0seQnfCCLVqMchAjK9AKzP+CkJV64tsMfmQrJRc3HzSPH1yn6+jnKAKmrTZKSQA3dkV4dmNISpfHNYOASjOI0zxPgBg6XhdI80ZicozVV9BhP3NJbEIR7/ai6LsU/qELDh/p7eDqgqbDjsiy4AavQ3xnvz8deUhzZHyKX5qJJwl4mV2jlYqtHg0vzOMrzVqoub/4Oqyg5Hafg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=P/ba9sCb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=P/ba9sCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqpdH3s4Hz2ySk
	for <linux-erofs@lists.ozlabs.org>; Wed, 08 Apr 2026 00:35:15 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1917949a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 07:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775572513; cv=none;
        d=google.com; s=arc-20240605;
        b=CcVXZOH8pyljF6KwI4wQLK9Cs+ZoicZINS+zj0Z8OvzGspOtnNVIsiuHQ2ZWiNl6rk
         gtOmCej9MVN4bk2k9ot+q5wQzVLzSCZNVBcb1V2X0EdK2lA0kHmMgiGvXurVWbzWKFnn
         K+6VN5d0wtqCUbta5iNESkay0iBmoowmk1L+EUDrD/HMzroHYknS5pJHTuzocTtHDdTg
         iQE1OznQF/Vhy0cVXnkf8+S7yWCO7i8CDxfeK9odaPMUpKAlBH0y1GDNCM5ls9He9h14
         +oKL9ByqX/fFnna/X420PYdbY/233EmlDLK/g1MbSUd0kC0Db7P+oadthz0wote885PQ
         wfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        fh=EhnoZT0OBhfT7iWqh0Kl0/+hJYUjgnnKIGgAB9M4Iak=;
        b=gzLLqxAPVCkdvB/MWsXNtbhZwzMkLs5jSTULNP4K9x3ibm86xdxnUbb55GuxvFDYto
         k2nxQ9Xc7OPZ+LWG8+3uF0Tzohn1UZQs/wRiE4JS9SjoPq8BSElS0b2krYID5h8IHkns
         46BfvYYXta4UCtlqfYU7E+d8oxU7vuI5rHYGQaKCZstn1izSVhXTBIl5ZdEyuEEsR+iJ
         xHtUUcnOtMQ+c/I7tjcsq9O87a3dOZeLRZNmfHL3htXO8nAhtzafJnxZq/yQScDss905
         Um9hTDqE9tmWVssou/08IDYpkDKUaNhtWe5qEAerSEqBphNoV1PT9gSD1kn6uA4BG2tW
         yqHQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775572513; x=1776177313; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=P/ba9sCb9PVEx38xIGEh8LHVmMVtCKL1oRn8vZCkRHF41Ww2povulKNIG99l70/Ngt
         hAEIqR0eVUGJTyKz2oXH315rXQZfMA/c+q/Ef0xAaUsOWHQ83VIze7jBKJXGhFYqJxPE
         NPxOd9jD7R9MjbgtsGx1XyD1WoU4hcvFDRxfXPZi7ZhMTDuaeUzGsIOTeXHYeJaLqwnB
         tzgEvzixm3umUDBZsI+jV5pYq3n0yVO3h4uyPULzUR56qGKAdz2GMuQe1079l/vke5WH
         KPFPrmFVlYknW5KTqB5EA3Dyd0sbbc+XmKc8aMXZqO4I6iMIWAupWRWS3PpjbAg1KKTm
         DkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572513; x=1776177313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qC5HIWFMfgCC7dxk8CsqfkMoXma/koXyhFD7US+Mog=;
        b=g1Gtjxm06dRuAvCe5DpkK9t6xBDIZr+qwJuxW54OufxRxJTVCc3q9dZMOgFXwvFl2Z
         q8bzc39CfVEpqVj/6DpjYHdfTv/19DLbjBHMWpg/aioqGLnp3ATSPqflcigK1SMK3nY6
         pKUj9YG8mGGxzhmO54J7AFBp3hB3Nbbx9VY5vT5XWwdvrEMhhP+G/bRyL0H1owuiv5sZ
         VgooEbfr8YmT4QJf41P0Mz+SxEZuzPQQuvONFAjWzc7mGCTsQ64dzUTP2jN1XYd2CzoT
         R97C/b/zBm9UHZDj+NN/ZNceLwBBSpEAjMYk2oVif5bnCuWI8vNQ/8gM07z/RC8+zzDI
         9vXw==
X-Forwarded-Encrypted: i=1; AJvYcCUu1aUv0PwrslA4wjPnHw9lV8NMIdO3iZOYKcrnJY69JoddOS3oopbptsFuTXXAy7pzdh/dYEKpdjtCVA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwYwU0zvKWeX7oXzZYqEw7zsBhD6cp8aUAoahCyizlvxeve93fm
	QuGF6S9EDgoIuhoF6XU8yLJbXHehKG1zH+6bBJbZOTmeExeg2rkECG0ubkzAoK5ufeCSrp5UPdU
	33q1eynkftMcVcxGbcLOlFnDMkEHVJziHv5gcBduv
X-Gm-Gg: AeBDiet2ZXfDeuTwNzWzluZq3U3F1MwA6g33zgtgtI1S0LeHq+X1kOi5tJ8porBVSpa
	YLNUOe/bJDBxs0/OatG5A8JMBmsqokHHAlhpG+46RUU2ZLdrGyKHMjZ8JhKdIMrxR7W98BHR+7O
	orENJt4NlgtJJxl5CyMFZbV25A+p1QQxTLKr2aKMgl4VUtueNOFSEJ/u/bPO816GwKpa+2aAaB4
	jMdUTdjfWv/nAGAAU2P37KkzxOSX8iZk9yABqqwV81ax21TKoLUQAcySVC9Hlq8Y43NP1I4gJix
	UIgWvVc=
X-Received: by 2002:a05:6a20:a91f:b0:39f:75a6:16e3 with SMTP id
 adf61e73a8af0-39f75a642ddmr6186836637.2.1775572512468; Tue, 07 Apr 2026
 07:35:12 -0700 (PDT)
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
 <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Apr 2026 10:35:00 -0400
X-Gm-Features: AQROBzCbJor8xEV12qkCxYwq58fXkfkjQP4svTBOSHpDEN5glYblz9lJ5v7xffk
Message-ID: <CAHC9VhQnA38-9wDeVmOMxAFPHnd9y6x5LXtD3cSquGiL_MDDpA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3216-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lists.ozlabs.org,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A253F3B01EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing SELinux security model for overlayfs is to allow access if
> > the current task is able to access the top level file (the "user" file)
> > and the mounter's credentials are sufficient to access the lower
> > level file (the "backing" file).  Unfortunately, the current code does
> > not properly enforce these access controls for both mmap() and mprotect=
()
> > operations on overlayfs filesystems.
> >
> > This patch makes use of the newly created security_mmap_backing_file()
> > LSM hook to provide the missing backing file enforcement for mmap()
> > operations, and leverages the backing file API and new LSM blob to
> > provide the necessary information to properly enforce the mprotect()
> > access controls.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Do you have tests for these changes showing the before and after (i.e.
> failing without your patches, passing with them)? I tried running an
> earlier set from Ondrej but they failed.

A few months ago I sent you and Ondrej some feedback on those early
tests from Ondrej, but yes, I also had problems with Ondrej's tests.
I've been using a hacked up combination of the existing tests, some of
Ondrej's additions, and an additional debug/test patch to ensure the
labeling is correct.  It's far from ideal, but I didn't invest time in
test development as I assumed Ondrej would continue his efforts there
(unfortunately it doesn't appear that he has?), and I wanted to focus
on getting a solution as soon as possible for obvious reasons.

--=20
paul-moore.com

