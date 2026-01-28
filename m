Return-Path: <linux-erofs+bounces-2233-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFdoDUr+eWm71QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2233-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 13:17:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D8A1132
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jan 2026 13:17:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1Lqp5JtPz2xlK;
	Wed, 28 Jan 2026 23:17:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769602630;
	cv=none; b=ExQmub66ZKp/RLTbDfjT8XLbvlYsB6gHgXcBQTmTv2fCNJYb0s03Ce2Z5EV6FgoqxsKVfMPGOG9E/BVyCUCqQwDamiezB+PpkFkN2hatl+cmyDGussCyewJnrWfp9K/b5g8gCaRtwmKvROnFtNz0lVqpD/K8ZlG0aIzQlYIAGR+tuGFooiEMqYFVdgJxErAwx3RrpG+f4BGRwCMXjoTrL59gcdlNKzl8mVcbnQdnKyDwnlqV4G5qjvnhQHk845YD1UAfcJRFIr/LSAsBOUOyRnryD2nyrCmGvo3PIXllP8v42R6mbBnwLywhRVRMq3x9Fb7KD5DOkIW8vb7/loTUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769602630; c=relaxed/relaxed;
	bh=Sd3tTNC9Qi1NraZ3FKZVjxKypYrlKrXHxdzsRn97YZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRlXD/deIEUsCgKJ0C79UYJrZGVlLdZHvBGh1AvZLXOvm7mHioQhCvUvcxfezHKhLMqK0BAHXEj4mfBgxX6pUffRSwHW4JYoVG9eRan5lgRmmhJCMZQBVdOervf6BAgUARAS7pk20NkucjzTmEG1omYwaK1TQ53BVsnuQ/1qdMB+aUvxoOONxhhG639yT/7dfEyv05eVk2DI7R9NgLWUBkr6lldy5X0wMmcQnHvd0SK11QFY2rWYxkbDJvenuUZ57D7RQ8dcjGEn9jZu4B8kZ4eXQA+HT9XlofHcbqU5YxXwNHCPNnPB7sKwer5k2y/5PJwXnEgvpr9OP3pwQ9x94g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=meta.com; dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=s2048-2025-q2 header.b=gTRY/WK5; dkim-atps=neutral; spf=pass (client-ip=67.231.145.42; helo=mx0a-00082601.pphosted.com; envelope-from=prvs=048834cd31=clm@meta.com; receiver=lists.ozlabs.org) smtp.mailfrom=meta.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=s2048-2025-q2 header.b=gTRY/WK5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=meta.com (client-ip=67.231.145.42; helo=mx0a-00082601.pphosted.com; envelope-from=prvs=048834cd31=clm@meta.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 275 seconds by postgrey-1.37 at boromir; Wed, 28 Jan 2026 23:17:08 AEDT
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1Lqm6Ysmz2xjK
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jan 2026 23:17:08 +1100 (AEDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SB138M1478460;
	Wed, 28 Jan 2026 04:12:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Sd3tTNC9Qi1NraZ3FKZVjxKypYrlKrXHxdzsRn97YZE=; b=gTRY/WK5dlMJ
	+w33bnXlRn1cCiq77T2CcMcXQkZLDeCgVL96iSn62FmkkrRxzBM9MIvA0/cb+Yqp
	7K2voFCBRv+61xwztZqJKWxwspJ55PsOpC1EDOp9KTPbF6BIJWuk9ijNdT5ye3hN
	2qFlu8Baf7zOiO2sS+AFcRFjCj8EIQBI+FWjL8w8MnzADaoEJNxQSdivlV6UW3he
	/wb0Y/R32ZcnznUNp/NThA2xnL9bV+ILuQu5yUUX8YQKP21FSmcApEMpZ5O3AuC3
	/zWNiD+9HEYCHz+k7PzzpBd2lBlTxy8vvfv8sVuLDoGyHUQax4GHXHh1oNeRoIln
	Y1F/zIHK8w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bycg226fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Jan 2026 04:12:23 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 28 Jan 2026 12:12:18 +0000
From: Chris Mason <clm@meta.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen
	<jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma
	<vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula
	<jani.nikula@linux.intel.com>,
        Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        Christian Koenig
	<christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, Matthew Auld
	<matthew.auld@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Gao Xiang
	<xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>,
        Mike Marshall
	<hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Tony Luck
	<tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave
 Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Babu Moger
	<babu.moger@amd.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal
	<dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn
	<jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett"
	<Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
	<rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko
	<mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Nico Pache
	<npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang
	<lance.yang@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato
	<pfalcato@suse.de>, David Howells <dhowells@redhat.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn"
	<serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>, <ntfs3@lists.linux.dev>,
        <devel@lists.orangefs.org>, <linux-xfs@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        Jason
 Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 07/13] mm: update secretmem to use VMA flags on mmap_prepare
Date: Wed, 28 Jan 2026 04:08:36 -0800
Message-ID: <20260128121200.283932-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com> <a243a09b0a5d0581e963d696de1735f61f5b2075.1769097829.git.lorenzo.stoakes@oracle.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:108::150d]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5OCBTYWx0ZWRfX/YMdvd0IEW+M
 mfJ/bYR9k4eRvDbs9QGzO+ygu2VSotJCKMMxUusrpYkrvYdQaFJRWVvBv2EkD12mCpCYEvw+XB/
 DwyN2M8BBbTeyqqZ9/i9fDyEPE0MOIwU1pNj8r3a1/SGXN38+xZGlcMtDVhwJA1iofmGT+NTjsa
 3wJFzmew6yuj81cYLEWiubhhxDZMBD6hVVMuqCOVg+bB7Gz9bEYCH56KvIcfJ13/7NnDlwWy1ay
 rut+pW91VzKqtLFjeZDFQXQuymj3+pWlazUmuuQXtfS+yB5rh8eIrZb/ZGDSDilJLhwKOSnwEsm
 tXIPQzyp+XE21UBIWU7JysVYMwhm9BUIbA4gV+4NNGJrteyEtklAhziLQl5fV0j0MzIV6sri7hz
 h9QDQw7JEBl4y5dfKeMuesm0LqUNBE+g04KLVmq1Y9FiJcFdRQVCoCh0B4S6SthUPRAGT0RWyAc
 Vh/HaT4eUcQ+KnB1bbQ==
X-Proofpoint-GUID: 6cECoo2vZpz-_Y4sX-WfJbWu0BG9k_53
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=6979fd27 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=VZ3cX_PGfQEInpbj4y4A:9
X-Proofpoint-ORIG-GUID: 6cECoo2vZpz-_Y4sX-WfJbWu0BG9k_53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo.stoakes@oracle.com,m:akpm@linux-foundation.org,m:jarkko@kernel.org,m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:christian.koenig@amd.com,m:ray.huang@amd.com,m:matthew.auld@intel.com,m:matthew.brost@intel.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:bcrl@kvack.org,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kern
 el.org,m:almaz.alexandrovich@paragon-software.com,m:hubcap@omnibond.com,m:martin@omnibond.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:cem@kernel.org,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:jannh@google.com,m:pfalcato@suse.de,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-ero
 fs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:jgg@nvidia.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.intel.com,redhat.com,alien8.de,zytor.com,arndb.de,linuxfoundation.org,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,amd.com,zeniv.linux.org.uk,suse.cz,kvack.org,linux.alibaba.com,google.com,huawei.com,vivo.com,mit.edu,dilger.ca,linux.dev,paragon-software.com,omnibond.com,arm.com,wdc.com,infradead.org,oracle.com,suse.com,nvidia.com,paul-moore.com,namei.org,hallyn.com,rasmusvillemoes.dk,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,lists.ozlabs.org,lists.orangefs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2233-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[clm@meta.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_GT_50(0.00)[94];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,meta.com:mid,meta.com:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 334D8A1132
X-Rspamd-Action: no action

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> This patch updates secretmem to use the new vma_flags_t type which will
> soon supersede vm_flags_t altogether.
> 
> In order to make this change we also have to update mlock_future_ok(), we
> replace the vm_flags_t parameter with a simple boolean is_vma_locked one,
> which also simplifies the invocation here.
> 
> This is laying the groundwork for eliminating the vm_flags_t in
> vm_area_desc and more broadly throughout the kernel.
> 

Hi everyone,

Running mm-new through AI review flagged this one:

> diff --git a/mm/mmap.c b/mm/mmap.c
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -225,12 +225,12 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>  	return hint;
>  }
>
> -bool mlock_future_ok(const struct mm_struct *mm, vm_flags_t vm_flags,
> -			unsigned long bytes)
> +bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
> +		     unsigned long bytes)
>  {
>  	unsigned long locked_pages, limit_pages;
>
> -	if (!(vm_flags & VM_LOCKED) || capable(CAP_IPC_LOCK))
> +	if (!is_vma_locked || capable(CAP_IPC_LOCK))
>  		return true;

[ ... ]

> @@ -416,7 +416,7 @@
>  		if (!can_do_mlock())
>  			return -EPERM;
>
> -	if (!mlock_future_ok(mm, vm_flags, len))
> +	if (!mlock_future_ok(mm, vm_flags & VM_LOCKED, len))
>  		return -EAGAIN;

This looks correct - do_mmap() now extracts the VM_LOCKED bit from
vm_flags and passes that to mlock_future_ok().

However, it appears check_brk_limits() was not updated when
mlock_future_ok() changed its signature. The function at mm/mmap.c:111
still passes the raw def_flags value:

    return mlock_future_ok(current->mm, current->mm->def_flags, len)
        ? 0 : -EAGAIN;

When def_flags has any bit set, this converts to true, incorrectly
triggering mlock limit checks even when VM_LOCKED is not set. Should
this be passing (current->mm->def_flags & VM_LOCKED) instead?

[ ... ]

Additionally, the test stub at tools/testing/vma/vma_internal.h:1627
still has the old signature (mm, vm_flags_t vm_flags, bytes) while the
production code now uses (mm, bool is_vma_locked, bytes). This could
cause compilation issues or mask bugs in the test suite.



