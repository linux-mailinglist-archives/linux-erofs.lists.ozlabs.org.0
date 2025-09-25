Return-Path: <linux-erofs+bounces-1106-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 621D6BA01F3
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 17:06:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXcWH0sNVz2yqR;
	Fri, 26 Sep 2025 01:06:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::449"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758812811;
	cv=none; b=oohIB+AsF6ItdS0hWLadXCbfjc8PA7IyYPlwcMpVOW0azCFjdXu3UnEFPHMJl7Zk/EexUMQX8QA6SWIkv0OTldjGSQW3X84+J0C4JwmX4DkcvrfSdaDpzCKWmzRED3t9PaolXdkRmZfb5Ug5rDoTEsPEIelRvgJ1H9fAQdijKyLhKC0D12znbbAX7ToeRpo0K54deoUze15Ihbv+Zds6R87UIHSwpXR5fBr+GNVb2JgaC33ItiM/P32DOe1lVCOmzORgNK4gKEtrkjonjCF0Y7t9KXdyMuSjz3F3ln6DI8gYL5MW5OfofWS22UMVQNgguzCwLN5VRL+kuojhWYOB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758812811; c=relaxed/relaxed;
	bh=Jh5MSqTLsjrp4fvoa9f2K3rue2zEjmwO4t9rR+bj9fI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NPrhz5zL39BPR4AsRV2BNAEzOyM57fFYE6VEoD/Cc8ZS3ef2F+vKMk2MV7CTZN+AiKQmARVuV0zeVehVAkyMhCZfe6CNX4q4rhILsZ8OlNxHWsF1qLapCNnRxk7AaEM/n7lBA/d2GyE9XWay0U/T6WX193srA62qpu3xv98W4fkmEIOOBLQA462Jsm3qLUzKvRAAwQdVLbY/jp9ib173FStchjGftPexFzBlvUXQ4TW74q4PkhcR1x/agwsONz4zBOlw9APK+lFhA3PQjDNHI9atJrBTDCdlPrhhvhQ9H/yCwNRtcJDLVSZW0Jn3owb+0EhLEF5Fl9hvnW04CtQqlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ohAzliRW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3hlrvaaykc90rd9mibfnnfkd.bnlkhmtw-dqnerkhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ohAzliRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=3hlrvaaykc90rd9mibfnnfkd.bnlkhmtw-dqnerkhrsr.nyk9ar.nqf@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXcWF66Rhz2yqP
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 01:06:49 +1000 (AEST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-78105c10afdso742825b3a.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758812807; x=1759417607; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5MSqTLsjrp4fvoa9f2K3rue2zEjmwO4t9rR+bj9fI=;
        b=ohAzliRWFUHaCz/JjITclxsVPi1cb8ogGGq18I+92KqnSBguW5RvOD2CvDmHd6h15y
         iI5mBBFwhhXiRge1U5yw350z2ygO2roRLGWDVHna9O8vJbhpOO0BAK+cccyWf6Tgdowk
         TNgKGaKA7pX9/ohq4/UsDOUvkrs68Fkdh9c02vLCNdipX6f0gN+rQOU4/qgJZdqLUH5e
         7/kbj3E99fNo6U3H97CGVHDIO2R0Qv1PmVEQkw0GHLENOhEVfWnEM9tVOzvLwBblZvD0
         zyNu6nEfBfRKI/ngLGz7KQ/EJ/sqjOTnZ8BChgySdPeC6skXZCbCFOb3MvNj9it/SWLf
         B29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812807; x=1759417607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh5MSqTLsjrp4fvoa9f2K3rue2zEjmwO4t9rR+bj9fI=;
        b=hKHaR4ALM9uBp6Y7/mEcPA9Gi+ex0QzkosfCDLYmD9BUNygfGDqUBrZbaaDqWQGjAq
         nk8yxXplgYtdq18AA/qBNc38+NnTfSueTmfq8gBp/qADFC3kufp2/Lz5E/zfrYj58bkT
         OFMQKy2cbhs5FdK8KlU6aXi7USGuswKvzG8Lk+q5FoRfovuekqYaCe8BtwTIZffCTvWL
         O01XYKaE1O52khpDP3FqPvArFCRdJ9VSFEypABAfc01LnDKpv4Vwc5ywBR7ZOFiqbfQN
         2orT1zZFCktqcG3SR/6J55K1P3y4LKiQcDH89bJUAhSPpKxbF0MiIW42H1tlAbS2a53T
         /M9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/NZ7jyx/niSa2A6H9LCbtU24J2bnTk8g4F3oYJwEuHj4p6O2J/zWWYaHqCosN4g0qxZLbVSkcU07Fyg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyjdLMZEeuVMPAFUqyf6l8LkC4QQW71JUAOEauv1HUZxlKie6kI
	nJz80vvYa5tUhywfZyfYF/zLVjieyxS3RKMUxn+ovEyS3f9eJs2OIFMcvdUaPJvNwVPEgB1zeh8
	tCruGQg==
X-Google-Smtp-Source: AGHT+IEVcWsyGM1w0GH1nNrshkk20Pnc8ghwxFB8MAUOFgcR14npidYwrEDITe3+YHWa4Mb/5XspEYhl1Ac=
X-Received: from pga11.prod.google.com ([2002:a05:6a02:4f8b:b0:b4c:213a:e7aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3282:b0:262:1611:6528
 with SMTP id adf61e73a8af0-2e7cdda0840mr4939471637.29.1758812806367; Thu, 25
 Sep 2025 08:06:46 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:06:44 -0700
In-Reply-To: <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
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
 <aNVFrZDAkHmgNNci@google.com> <3a82a197-495f-40c3-ae1b-500453e3d1ec@redhat.com>
Message-ID: <aNVahJkpJVVTVEkK@google.com>
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
> On 25.09.25 15:41, Sean Christopherson wrote:
> > Regarding timing, how much do people care about getting this into 6.18 in
> > particular?
> 
> I think it will be beneficial if we start getting stuff upstream. But
> waiting a bit longer probably doesn't hurt.
> 
> > AFAICT, this hasn't gotten any coverage in -next, which makes me a
> > little nervous.
> 
> Right.
> 
> If we agree, then Shivank can just respin a new version after the merge
> window.

Actually, if Shivank is ok with it, I'd be happy to post the next version(s).
I'll be focusing on the in-place conversion support for the next 1-2 weeks, and
have some (half-baked) refactoring changes to better leverage the inode support
from this series.

I can also plop the first three patches (the non-KVM changes) in a topic branch
straightaway, but not feed it into -next until the merge window closes.  The 0-day
bots scrapes kvm-x86, so that'd get us some early build-bot exposure, and we can
stop bugging the non-KVM folks.  Then when the dust settles on the KVM changes,
I can throw them into the same topic branch.

