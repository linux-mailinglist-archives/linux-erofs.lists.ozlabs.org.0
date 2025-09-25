Return-Path: <linux-erofs+bounces-1111-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013BBA1F04
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Sep 2025 01:13:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXqJC1ZX4z30BW;
	Fri, 26 Sep 2025 09:12:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758841979;
	cv=none; b=kP3ssd+Qjdtb9bSabkV6v1b6NlGa6hryaz3+f+X1p1YQUs4LG2YSEQ6H9u3rumsEwX02EicCoYrKa/CDm+3QFbWcVBkufkQV6JlrZglWsjMv9bwt04YSC9rZcqKF4UeswP+LSGuk9YiFO3cBeDhB6EaXJkEOTKb/fcaTKRGLdIMg78lJ28iwspXbgwOI1/MrvSP9uy9E+Ti50l3zIqlc5Tu5g9hDGN8VOQb8c23UR0HoXo1HBAXOqR61P7fHPwSTD/+hLKjccmNaWzDBj2mgMIdfUvulzdQwBEFMDeKlwaR29wcs9TwAq+JLN/1Y0lljJnDj0haapoxFV1zwIzNswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758841979; c=relaxed/relaxed;
	bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HSZaRVYI9JDGrzFjwGxORYPIiF0lMzPJP3jWArub2A8VrvolJnMKJxekUtkIgLN28Qf6qu2J1uWd5UOgpHThl2jKniPGGWCdZ2vxpnPkk38ZwY86ikRlyjT15RzJ0EnWW1KJtNJuqs1WhHqXkliSR3x5uP5yEJwv0A+KaPcFQPVET98VE/QKDFVdT0DURmePxi5EaF5EAkyAnTnubJhTSk1HZbqVRnL+3Sv9bX1tHfCS+L5ClpUzwYD36+/QdMHJR3TRuhBymUk9urVnob6+gZyhzzdeStLBodNj40KiAM4uAlUNlsPIInX8NFWIdxl/vSWOMbo+2NIdbEI/Vf02zA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=SbwbJRXI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3d8zvaaykc7qmyuhdwaiiafy.wigfchor-ylizmfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=SbwbJRXI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3d8zvaaykc7qmyuhdwaiiafy.wigfchor-ylizmfcmnm.itfuvm.ila@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXqJB2pc9z307q
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Sep 2025 09:12:57 +1000 (AEST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-27c62320f16so17702565ad.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841976; x=1759446776; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=SbwbJRXIxi/uR8LWbYcGNlNpm3NcgVA61i7JBm3Q8eoC6eozMrC+i7n9PxSvFW54sx
         owRK230KH0pcetA5+NjtgCBTCSfTasmxAN2rDu0wkhp60BDhw3tLuJBhj3I01VRxNIM2
         MBGrXlRjOIZc7Jop8CNQJrZY7gpcp1lnEm/H+LjoOOZhp0qFUM+ZdOzKGSEwNgXZVu7s
         GU8F9l0fVhSwx7LGVJavK4RJx/yqUuYgdwc2/F/I0BUCMvRXUM3A9QdilA7+dJ+T2IEr
         ecf0+KsLv7MA5vAIWesLscrt02jSuciqaAMDuRd8PUYP+WQXYWUaA6/iBQ74j69l8hnz
         zxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841976; x=1759446776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGCCSnKnyPGGdnUTp10aKL37FULfLm3dyeD1VoFdI2I=;
        b=dWrBBId1UgN2mTDYFa5hdfvqQmhCXa8c4jKuBdcsmRDolrLFh2hNLn01N+POoF1nQq
         JwOT2fRPgzuvJtp9yaHzWq6L36mIa1zUy5U7lCaA4rE6xnPiiwanHWYPBZOz4xwswScZ
         OIJxSYtiXrPGiuKTcAjzsMVdtEf8XMMHUFRvKcYsLaP5ynh9oc/+2bAb+kwZK+XhmkHA
         DV7Y1rKd1luDS+nUvhcLX/b81bprZQYg4ndovfysQgDXY++0kIeEGUjUkdeyC8QdnCvT
         LF5FCIJni1VUtV2w5LoK4PVFTWPJvTevrkOqTlWvm7Q2MqzesF5L65ERU1Dssu/1rLxc
         IF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhElnKlMhf1OdZ0nh1h+NBCrvauRHOElNWS/+Z4+6rR4FtRiaCP5wFdBT9PP3SzTSDUL/puOPvZROP/w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFy5mn6Y/v+ameng8WO5M0xFiRTmTuEPfYFU1GZBFtBZOexXoI
	DA9FBYaXWwaHIPSypll/aVgGmhxrQweEzZfdjC5p1DHEoSUQP50qvqRcS2mN8ZW0rt5mDnPWS5V
	9hwAbhA==
X-Google-Smtp-Source: AGHT+IFE8gFtFdnHNmX2p6THQrFO41fYST4gwotcfBj6rGswgxHnE9CG8NuKci3w5GnRskLMvJFI/+Q8X0o=
X-Received: from pjbjz6.prod.google.com ([2002:a17:90b:14c6:b0:330:9af8:3e1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e883:b0:262:79a:93fb
 with SMTP id d9443c01a7336-27ed4a7ecbdmr51468535ad.32.1758841975402; Thu, 25
 Sep 2025 16:12:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:12:53 -0700
In-Reply-To: <20250925230420.GC2617119@nvidia.com>
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
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com> <20250925230420.GC2617119@nvidia.com>
Message-ID: <aNXMdSZkqDtsGRLm@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shivank Garg <shivankg@amd.com>, willy@infradead.org, akpm@linux-foundation.org, 
	david@redhat.com, pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
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

On Thu, Sep 25, 2025, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:35:19PM -0700, Sean Christopherson wrote:
> > >  LDLIBS += -ldl
> > > +LDLIBS += -lnuma
> > 
> > Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> > any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> > trivial, but I'm a little wary of foisting that requirement on all KVM developers
> > and build bots.
> 
> Wouldn't it be great if the kselftest build system used something like
> meson and could work around these little issues without breaking the
> whole build ? :(
> 
> Does anyone else think this?
> 
> Every time I try to build kselftsts I just ignore all the errors the
> fly by because the one bit I wanted did build properly anyhow.

I'm indifferent, as I literally never build all of kselftests, I just build KVM
selftests.  But I'm probably in the minority for the kernel overall.

