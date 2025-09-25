Return-Path: <linux-erofs+bounces-1101-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC1B9FA4C
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Sep 2025 15:45:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXZhr1s1Cz2yx8;
	Thu, 25 Sep 2025 23:45:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::832"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758807900;
	cv=none; b=IXt1Ypzpm8+gyD0+WBajR2JQo7YaprcR3deh0WbFJo6Hshnwr1f9ncVPogRVdLWkWLRyJReV4OAzFP/en5SxtFDtym97mX/DpEIVgA0ch8Z35cOXIxKcbdNO7bAJV8iU3m+gStZXPsjmznCLt8cFnz1LGUPAgH4pH3F05eUVUrG1NTQ1VDqRE6UosToSn/Dt9TbVOziArpu+9t4AGT8MVKraWRld+fUL7Onl1rwFo3eabmoNfBreoyWMeiexKGllgYZ+OersUUBd8wqbuxJvBx/FENlHhdOr3DSkDebD+YZApc7ajgyz+u0ullt7D+9wenbDhQr2eO3iIl8JU9t8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758807900; c=relaxed/relaxed;
	bh=N5TRZaIKsL5BDWNX1fB2oE8143OJVf1xWjoYHdxo8R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRu4CH2iuCiDV6QwCyiNCjuRTs0ZA/PSIGbxpUA/5Cr68OEycQnfijlCHpVk1XtjmBlPUMrHSQLOIltrYzr/wTW6bMAxAHrS/AHKfuKPQKxBi3HbksRR7o8775ETAu3cIcO5NqgWoV/9xA5vlu+3fOWADFgCP0X0481CzV9+ewCDr5axEnVEyiTIP8YOKjjVVa+4YgDYvdd95L56koSO9FWktqUgdWrNZlbE8D7bf13owByFeknqciVOh/xTKqQ3vhIKS0OPiJBaDQgINgnEGikkpxmQC8jeOuaA0aAobxhaxrkOTiE1iKibIcYTrW+Wm2gmsLF9qXhP0gL1cIWvWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Orbvl0rw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=tabba@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Orbvl0rw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=tabba@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXZhq3szFz2yqP
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 23:44:59 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4bb7209ec97so1147561cf.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Sep 2025 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758807896; x=1759412696; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5TRZaIKsL5BDWNX1fB2oE8143OJVf1xWjoYHdxo8R0=;
        b=Orbvl0rwW99Tg9/XU8vZDhCmEahN2g6/QSam9K9p9cw6kVcghKFGDkyBua2UTCE/Qa
         6xH5RqHA3k3W8kJUUKIaJ4C9yLVTKNBxNxolTbAfwLC83xYa7ORFl5i2FPrziKgGO/9e
         ID/y6kCJmtSitv/dKxBg6WWweGqV7z/J4F7yOvsKvKuFBSlxnbQAWvzEaMUw5kNMbsnT
         HsqiV2qwTHRh1y7oLfppUsXJyOUz9Np4sGSjTcHy9Uh8hSfBRvwZ1hQlb6gXUZgsGVdG
         BibwP1I9blZkIcDLu0jCXNY0hujuDRxaQVrk4Q+dWpuc86comvyoLE+DlEGpDUOb6m4S
         vXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758807896; x=1759412696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5TRZaIKsL5BDWNX1fB2oE8143OJVf1xWjoYHdxo8R0=;
        b=IHQPIgq2hZJAFOwZxy4sjnvNfFn7UglT0+cPBQ2meIyVq5N2XEAuTRcx1a8CWig0PZ
         vWCKOlXfF2oKvqgX7Jc90gAnG3x2BBEjulmrVp+pD/uWEZVcG0jD8R6DlaODXD+YbGik
         gnTuBHoyYWoiNZmVAw+ch/Cr2XgYS58hwlhZHn1W4GGTzPYYl+fEUEEoY/CRdFVvjp/g
         oEyaHQhD1kJKJ6w62QpQlKCzcw2qyJEUR3OG3Q1tuQmNGdLQzrX2OmX4sI3+LUnReb2G
         1y2KE+R6XlZFZ5bgWqHmHSWlDF1BcSt4ONjx8qlr9Cl3F+Eno8ThZYgS7UzDadSTTWC4
         NKLg==
X-Forwarded-Encrypted: i=1; AJvYcCVPMbMVd3aLG+hpIjHIEOKQjzlyOroj6xdxvwOh1Ea6qniNrUbJTk8nh468CDHo4ZiZZAS98Knmm2mS7Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnplMptV8ZAgMvsIJQKMDx6OOcQTZYQlQNcQSm10FXGLp3gBa9
	sbCQ6WbQMl4aUnQJ7gU9T/NzFhKjgZYbLAD10CMH9eDSUgTAxGRID5mq1gY0UNWFbobPCJm9mOk
	u5nIJO3npCOZE474gnu2w0u4jJ/Q/icbbBk4OeXnr
X-Gm-Gg: ASbGncvz8uusxYjlnm8/pfSIbPArFy9Aku+wvaIZzCbsy6kQElPsIPnRVr7o7kVTIHc
	+ADmoCxfJczGxqyt1FYY8b0XeSwckLyJhRTwazeeqjK3Sz4WE9oda9XuQ8BocQrGvR0Hcg8Va+1
	ioYPIaRe1662Uyvhnv9mbmja+jw+8E0tdlKaBMzaq9oVdMXLy/nlC2r6cO/Zb7nCUb/XGlSJhEy
	95G7FZZMv1gqx3uAr6wnu8VFw==
X-Google-Smtp-Source: AGHT+IHMjlzJoU4go98o9OLI3ONqf4XSyVwqhgPkrMYYKQ3q5Z+I56IySJAtT5Z6pWwXAgA4n71MeTiHJXaU1zjAWA0=
X-Received: by 2002:ac8:5996:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4da2f12a974mr6481551cf.10.1758807895145; Thu, 25 Sep 2025
 06:44:55 -0700 (PDT)
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
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
 <diqztt1sbd2v.fsf@google.com> <aNSt9QT8dmpDK1eE@google.com>
 <dc6eb85f-87b6-43a1-b1f7-4727c0b834cc@amd.com> <b67dd7cd-2c1c-4566-badf-32082d8cd952@redhat.com>
 <aNVFrZDAkHmgNNci@google.com>
In-Reply-To: <aNVFrZDAkHmgNNci@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Sep 2025 14:44:18 +0100
X-Gm-Features: AS18NWD8QPp_e9025CtzHt-1GmqDfc-4KC-skp25M5mSn0nTsRNLyfZiLblKLT4
Message-ID: <CA+EHjTz=PnAOdjaPuHRnXE+CTUHCKVSnf-LA6bgwKpWbapy_0Q@mail.gmail.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
To: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, willy@infradead.org, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com, 
	jack@suse.cz, hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Thu, 25 Sept 2025 at 14:41, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Sep 25, 2025, David Hildenbrand wrote:
> > On 25.09.25 13:44, Garg, Shivank wrote:
> > > On 9/25/2025 8:20 AM, Sean Christopherson wrote:
> > > I did functional testing and it works fine.
> >
> > I can queue this instead. I guess I can reuse the patch description and add
> > Sean as author + add his SOB (if he agrees).
>
> Eh, Ackerley and Fuad did all the work.  If I had provided feedback earlier,
> this would have been handled in a new version.  If they are ok with the changes,
> I would prefer they remain co-authors.

These changes are ok by me.
/fuad

> Regarding timing, how much do people care about getting this into 6.18 in
> particular?  AFAICT, this hasn't gotten any coverage in -next, which makes me a
> little nervous.

