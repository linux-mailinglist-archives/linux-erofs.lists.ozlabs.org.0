Return-Path: <linux-erofs+bounces-1100-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A0B9F9FE
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 15:41:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXZdG4wzWz2yrm;
	Thu, 25 Sep 2025 23:41:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758807714;
	cv=none; b=OVGCZM0JstZTrzS45J4DGTsgfirmtsY+Vvr8zsQGpVzdTaXUW4ezKC9xIFN0XMtKlmwNmm/wurA1qu8mHFhx4qjaBTaK8gYRi6/m6CgX0g8I6jeWMMZX1yUWJjgOAAWQ4eQVo8OChXUZcqoJDtiRi7m39XoXHHKnJhhpmNE4Krz4FkHmK5zMPHWJj7Xy1HQrpXJTR6lf97zBnZcDjYXJubjVKsLNYdE46JDbrCvYcaBM8P3wKyzKozXf96iWiZ/cEg3cU0V1di5eBxBZTSYXEaAuVc3fHIX6CIKUQr07zcWuvWuwnGpxLVkWh7Z2kl6lDE1GKMgVyBHjsIYI0byU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758807714; c=relaxed/relaxed;
	bh=dU4j5xINCBqy1Rj7i7G1Vfx3gRcoZTHMrIeb9JUSMNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BWTHNB/jTTbh+Km5lnvMUHDANwL1xLhyVLCUw649q/y9bVvKGgDYblGJSMyqEa13QuGVTCFigfAI4S5gYVzvtjf3khugWyvRgOo/YQ4eWZUxd2s7/O8occg4JOPcjIJQAm14kdC8Vd8XNcYJ0Ka3V2eOpSSN56kOlR4gSFCCg9wxmQU176UNPpxL0AoWA7Jh8UbAoAc7eHTzeLukCGnnRWAGxR0l4S2mDPiGiwgOu1J6J6ivUvbUJFuEpdW6Xt8Kf0wG68of+SrhB8G+DXWrqqyjKm6qRfWiZ+TLLmSXKJgMI7MngmXTdpQxQa4/tS7nkDvgBguQ5C+XrCspfYEJwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=1Flq1yF7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3nubvaaykc8waws51uy66y3w.u64305cf-w96xa30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=1Flq1yF7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3nubvaaykc8waws51uy66y3w.u64305cf-w96xa30aba.6h3sta.69y@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXZdD5XB7z2yqP
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 23:41:51 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-32ec2211659so1112261a91.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758807710; x=1759412510; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4j5xINCBqy1Rj7i7G1Vfx3gRcoZTHMrIeb9JUSMNk=;
        b=1Flq1yF7FRytmyMHwnhnLTgr7ZYxXBB0zYas0lMZ3zhX72VUeRNpRolXiGY6LiNadF
         IGqGYwNhOgjjTznfna4w3sAAeB/kkDNVwSMOPvweHGhTy8DrGySHN3SJ5GjZS3X5Cg3U
         JK6932nRgjOptUiSmveBF6m15xO05gV0Y2mK7ug4zSHX5FvGShiEquk/dAMmk2F2oxb/
         dAPiOH6kYHKSCUUUGk4L1LqiBe5jHdJcsRQgeHkaL7c7eN2VofeeLlB+nhsN9Huq0Avl
         43cJWgCAcWQyI5dW+B6dTvWmFakTMQvS5T04ss2t4naSJPqZIFimuRcvz3AcCxPNyLte
         S3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807710; x=1759412510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dU4j5xINCBqy1Rj7i7G1Vfx3gRcoZTHMrIeb9JUSMNk=;
        b=BTtt1cuNomCYi4Y9ycBTHU4xMIfZ/cd/HVLhRETu02ZD+xwXVmoUvI0eI5WZItCSAD
         1zcRHGzOCYyDoHoTk2cYlvkoEbTwX2nGs6Ztca/nYfxqbpdYAr8+0EHnFlx5tsozHVEN
         r6WOOHz0y8ZDpoLSegCa47fUTSEhHR/sRUphKQBuOzuTeFNSZI4gJB8oyDXQoIWFxKmD
         KoGFhByb4EYjThodlngkcr3PWm9atDvtJd3j2+HhCExgzWUVtn+1SPP1UFXLuHt41lgu
         lI4ur/Mj2Xmo/jj+xbvGIJ584Tri87tR/DrGzQqHMr5z3T4uG6SspzaatjGXgdtTdTr4
         x6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2zCIa8GfnMKepZZBGcZ34ZSoILWvdIaeRx9e303uJ9I3/wpIx8NF3xxrqJkbHGxvt+YGY8Gz0MzQcrg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL1R3r6ZVErk4xRQqHh6wNUwhTF6BAsY1/Ht8D+md/KdlL7OFf
	I2NY7rfBWPPU3BIibEo06ZpcVfn0jwjxmMMFdPOH6Ti+Cg6m34dsgJ89iawfvn9W967AlbB0Cln
	z6l+qiQ==
X-Google-Smtp-Source: AGHT+IGEjcBsUTlo4/vVd9aOmfS85HeXK7VXkMsc2AM9X82gWAt19f8n9mk94PI8ByiZcVy2ayMJHM96hBY=
X-Received: from pjbjx4.prod.google.com ([2002:a17:90b:46c4:b0:330:88c4:627])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c4a:b0:334:e020:2f16
 with SMTP id 98e67ed59e1d1-334e0202f83mr1618309a91.11.1758807709301; Thu, 25
 Sep 2025 06:41:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:41:42 -0700
In-Reply-To: <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
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
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
 <diqztt1sbd2v.fsf@google.com> <aNSt9QT8dmpDK1eE@google.com>
 <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com> <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
Message-ID: <aNVFrZDAkHmgNNci@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, willy@infradead.org, 
	akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org, 
	vbabka@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, chao.gao@intel.com, 
	bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com, 
	yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, 
	peterx@redhat.com, jack@suse.cz, hch@infradead.org, cgzones@googlemail.com, 
	ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com, 
	dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com, 
	jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, Sep 25, 2025, David Hildenbrand wrote:
> On 25.09.25 13:44, Garg, Shivank wrote:
> > On 9/25/2025 8:20 AM, Sean Christopherson wrote:
> > I did functional testing and it works fine.
> 
> I can queue this instead. I guess I can reuse the patch description and add
> Sean as author + add his SOB (if he agrees).

Eh, Ackerley and Fuad did all the work.  If I had provided feedback earlier,
this would have been handled in a new version.  If they are ok with the changes,
I would prefer they remain co-authors.

Regarding timing, how much do people care about getting this into 6.18 in
particular?  AFAICT, this hasn't gotten any coverage in -next, which makes me a
little nervous.

