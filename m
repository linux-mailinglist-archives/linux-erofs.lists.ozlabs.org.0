Return-Path: <linux-erofs+bounces-3688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jZKDJ5sNWoRwAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 18:21:50 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A16A7072
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2026 18:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Pv22j+Rs;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3688-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3688-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghjXR4RJCz3bqM;
	Sat, 20 Jun 2026 02:21:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781886103;
	cv=pass; b=iXgFFdFVVPGcbGyyhmDMOjuQMZJiKEYNxtkj+iuzYhoovNeM7e5QOUiCFM3aftDdq5BaXOaaDMtzTXd41DEa8bcLnNQTnyoc6vPYqnTChqXmJItJEJB31dD3LDL2dtsGZUcwKqYwDdfq8BjvY7PIONDqAjVmavDkhLJrsh6V9D/PVl1WVgk2iv771Z11HR8jTxhvszD8M8JZxwUcAy+G4ZbdASfaAU+J0mY9XzwnHfdXfrOfXSg8rawvuq0S+v8rTZCLnNMUDWWvkph/d0wLUw7YDKqWIiN3lGNJ/RKRDV8h9I6T8eGanA2BGqftWVmhv0lUGTebFOwSP2guRBK9Lg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781886103; c=relaxed/relaxed;
	bh=A5Azqep5mDr6QVgRIsQTYoj5ua339IZTPItc/KDuNdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fqdo1MTOWghh7t6ARqdCaKMHM+ce7lgK0NUT6B3co7xySZrRXOLLpgSXhE81zGsQFmWI1hmFZwRqNSBHn9N975C7hN6sxcDN7xDFbCoi0Bb8di5GaVeZN7FyIr0OOc5xUrIkNvtuQ+ucfFNAiXo6OmwZfKlo7gnVX0JdWFUzug1YFpOOqrClmNXmFMynZwwOm58Ccli/9gJFE94xMuRo87OqhK+SVIWp6KmJQR4ee2jmJnSSsmnQVK47QJ29Ua5ND+ktB6EbIrvmy9hKWM1qlDVlo5onRQfuzU29g5B9oN2eSN2nQz2sAfP/MMYnZZM6hFiTfgbc/guzrxC8V8FYiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pv22j+Rs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=michael.bommarito@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghjXN3Zf2z3bpm
	for <linux-erofs@lists.ozlabs.org>; Sat, 20 Jun 2026 02:21:39 +1000 (AEST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-7fd6b4d5d49so20190697b3.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2026 09:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781886095; cv=none;
        d=google.com; s=arc-20240605;
        b=cS2UO62u1nca+A+I/FP/A/j+940Nrnhl75s97I4hEoSeG4B7hMlkMiAxjLSS/u8+QX
         p6sZrmL3v9XVwu81TC0N4kp8LCeV6dOOkeYmTuWZY7sLbfHBZcMUcwegqcc8D6ErF7Oo
         Xd2dFu7s/X7R17Ud2r14QDls+9NvAnhsPvkBylDkNv8H4qslXMMw1Hp9E0VhAGajd0Qx
         b7wiLQp6CvunVVoXZr8VGJTBNYJFQuCgDZgbTUwli15sNG26BSoElZlvrsmU+/BJgVtd
         NsKn+aBTKUUd3DAoaeSxihvxcGqyb3sHxh48ycIXoJOb8jpWjA9L6HOJPtwdrxbpivDj
         pNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A5Azqep5mDr6QVgRIsQTYoj5ua339IZTPItc/KDuNdk=;
        fh=xo16bqmS35RVhp4D30vxAZihJPvo05qVxvK/7bwW4BQ=;
        b=HzHg8EU/IJ8PHorZ5jdtWjU0KB6+8tfpZ70T45LjpFTmP7lKIvecKLs0tabjKqFXGm
         ANNoGcCME6kuZZNfjInq66QlRPiVD7A/0s1EM3esvXgWssFkIIXATFa+trPxHhzT3G/m
         raw685z5kp/k7rl245K56Gl6/CnfszXzLJkh8XAzXCzWRTc4MWhc0avgOKhyMA+vScGp
         q3JWPuF1TWKktxq2EOl+ousEqD4+0t+BLmtSngm4TTt/p5KZYj7pOIKHqmteh1PxvbA+
         2mSSsTUNXUR8QQvwIS9zRcTpA9vjQxmpXdhy13UcZgGDuieu3SvormNekwcv728W1BVL
         nBVw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781886095; x=1782490895; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5Azqep5mDr6QVgRIsQTYoj5ua339IZTPItc/KDuNdk=;
        b=Pv22j+RsFc+b+y7JE07tbOMt/fdhFB5nDDmEjYD3IQi6sIQAyV0xsgcTJtWG3FCNbg
         L5K+QG6l/6+WMxLLj7jcKVtvEONg0m+idLDAC4RO9CJDecHu1z7ozYLDoOhT/sDGNzYl
         hw7SLuHNWthbR5WfqDw5kMQo1iwYGzgK0DEzvOoq+sVw2QV1K4JazATJL1l2bcNFa3oS
         h9LQeVQRliKV5Li55ajoC5s9JjGWyMBPNozXWYmPHy0Dv8iamthNbrP6KMgIEagihE+O
         6Gik6FtLdoZp+ztwOi41kwORvUSNL7+Gvp7fX4MHizlbATjKfK3Lk8Als1v85gO6/Fak
         Oxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781886095; x=1782490895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A5Azqep5mDr6QVgRIsQTYoj5ua339IZTPItc/KDuNdk=;
        b=GjoWd/ZpMcJ3yyMTQ2KJ3VOs7aN0G4SApt47e3d68OVyYvBPdwAwUrMxEpXjYTyaaa
         4fZYzlXwurGwP+SKplP2ryfO51cCWgYa8DXXmeNhPUHtaoW4758S4mMuIULO1zFc+W+9
         BT09j7vRskG6N9mipsZcQhDHyv2GzrK4ucQ9fiS2/vpFExr6u7fJbtqEmSuqyxnhMhHN
         iFOfW1AWUlZL9vo4JOw1aUT0oAHUm/q8Yo3neqCPtm0whLVZFbP/oh+kQ+2A82KpPQ4+
         845njLLmx/terNrSkhkZcjcdKBCas9G8j5o3i39rS9J2Pv42auntiBxIPZ5AHqeW2J2V
         63gA==
X-Forwarded-Encrypted: i=1; AFNElJ9ugqKJda2vVwG2e2QAdfvIGQ4R66C0zhA4cQ0uGcFhfsoMGTl2uPCBR6BaKXgrxaMDsyU3LbSX3Ms6TA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnrUWi66n3JrncuIqzGj+Dfr011pBYzm55nTKKhEykEUEI8IBi
	UmgbVL224/ioZlvTEr5bzQ6bEZO2gQUXRL2PNKwxcbcV0S2B8A1wGInkQBDrgfntKgpcDgzOpmE
	jtVsS6dnTqTr8oGjmjVUgoIHxmdRjJi0=
X-Gm-Gg: AfdE7cndE47MskOgVuym7T6gHx+KQDmJozifRxtsyx3yD0x/LyJcRBbmL/MwU2TmVnx
	QiWC0ls43Y/CIMjMt1n1XgpmK8x9hXFd35FAWJ+VHVP/BybQFG8s25sJ35DwzmtOVgqWRG9HnwK
	8bvIMozbmbRPPNIas4JWmuJggslsqI3y1jcvy9jpE4ylf+rnLPuOl4B4aPUacE4eSgqg2X7mwnw
	G7FHm8Jr76PRIyZRao1Zzs8j8txwbJf/9A8AnJaekdlywdSrm099Je1KnRHRmKWE2sKYcwbvoFS
	ojDYZs3Auw5wqSKnwU8J+oD8yfZdh08V69sc
X-Received: by 2002:a05:690c:6b04:b0:7e8:ec43:df37 with SMTP id
 00721157ae682-80123a8ac41mr33299457b3.18.1781886095221; Fri, 19 Jun 2026
 09:21:35 -0700 (PDT)
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
References: <20260619135800.1594811-1-michael.bommarito@gmail.com> <bffc5b69-2f90-41f5-9b93-fe527da63f64@linux.alibaba.com>
In-Reply-To: <bffc5b69-2f90-41f5-9b93-fe527da63f64@linux.alibaba.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 19 Jun 2026 12:21:23 -0400
X-Gm-Features: AVVi8CezYrqnzZMhKMzgs_W4UptK5Ko6za5tbTsZ0r7MH3EArEVtM-gzPsMhpEU
Message-ID: <CAJJ9bXws=fnBgMMbGcuWdhSRRe2yNb-QjFP-CKW=vaA0dWd+-g@mail.gmail.com>
Subject: Re: [PATCH] erofs: complete fscache pseudo-bio once when a read is split
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3688-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux.alibaba.com,google.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 226A16A7072

On Fri, Jun 19, 2026 at 10:20=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba=
.com> wrote:
> fscache is already deprecated, I will remove this path
> in this or the next cycle: it's not worth to improve
> this, and bio_inc_remaining is suspicious since I never
> tend to introduce chain pseudo-bios.

I didn't chase a POC for this one, but I can't rule out an LPE on the
or at least helpful shaping from this.

I know it's not relevant going forward, but the UAF / double free will
live forever unless stable@ gets something.

Thanks,
Mike

