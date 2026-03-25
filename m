Return-Path: <linux-erofs+bounces-2995-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CcSIfH2w2nPvAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2995-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:53:37 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9170327370
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:53:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgqfQ1r4fz2xcB;
	Thu, 26 Mar 2026 01:53:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774450414;
	cv=none; b=oMArToD0Xn8ONeVEoOTWbsh3bdCeHpvQ9uplx4NNmKV+taoFFFq8zwRSRsk8qklx35rmVVQ6HTO9xCblmh7FHb+Y9j9TUmCahfmGIfqRCnjg4gOVC+E3GlxYZIzBnQ00og5PmQ9z71eTde2uOsoMPUDt6maQM+stQyUDOv1OkXq0JPGivV4Jvx/6PgwqgXf4n0inC5b4un1MLlDtUlDJT7CrNX36UmVwJG103wubykdBPQVyRssaySYwu1jO1+i0eHu8PQPmT7TbN8+3Y34k3aSre6V6J+ASbysULMP5M4CAbyzBJZPIGDGq9LKliXwNk/Y65tzTdtebPcoOWliy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774450414; c=relaxed/relaxed;
	bh=pg9BGRjMnJsXPkM0swwEs/eI5ok+Dj8gFwFH1IOCh5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XflwRTzZgtfbASt0/zbM2+jCnJRbQX58gskbCHhU7XCvADDDF7R/fmItN+VdtKe+1ghJTL4Q5DpF+uiwZZDWQqwtUtRh766dhhLbNSOslgiHfUsq4yJN1e3Z22EaJv1JphBVkVso2T887p6VwXnRxe3kyug0XboELv4te/77TmQGSjEPOsH/5vw6yGQUf1QO0UFCLv4HqtK7dmYalAE9LJPqSFcy+XTf3p8g8pjyjcFsWDGYeK51peseiPey6QoHQwVwt1I72Q4JX+79DQP0ASLgjY2e2Gb/nr931v+Qa6a+0KlWRYohh/P2gXRUmtjaHufRvGBz89oZ+MpBCPFj3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bvHMKGo7; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bvHMKGo7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgqfP3FsWz2xS3
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 01:53:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5EA564189D;
	Wed, 25 Mar 2026 14:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1631AC4CEF7;
	Wed, 25 Mar 2026 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450411;
	bh=pg9BGRjMnJsXPkM0swwEs/eI5ok+Dj8gFwFH1IOCh5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvHMKGo7C2FvWUchrPoeFaP+aBjxBO1iDfBDPu1ftOdOR9CZZDLVUFhCz/c7WGA7e
	 why6Yw24IOjuRI1p2bP95VB6ClN3gKVLzT0jfMnfC6i/nYozQuCobhRSSwOyXF1N3e
	 byo4/RyWBj3jJuX+8109h+cusNOVoW1YRJJbnkzrjTlLtysvhWEr4e7NJhA0wos2+k
	 fx1cPkStcPHCC3jsOhMQDS1F6pwJ6xb82zQvvaulOqpwhrnvUJ/5TyvKvTmDP6MVMS
	 pJz6XV1MltczUwUgLDYNLrOBFtEIandUJarxRBC8UrloEnhtM8rgFwrglv5AFfDkkq
	 NMz0cLZrxbpPA==
Date: Wed, 25 Mar 2026 14:53:14 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: rename VMA flag helpers to be more readable
Message-ID: <f72132e1-a2a3-4445-80ec-adeb525dcfff@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
 <0f9cb3c511c478344fac0b3b3b0300bb95be95e9.1772704455.git.ljs@kernel.org>
 <6c6le67q23xsity3tkfq2uazzhwustmqcsqj3talft6qq737hz@dytog6bi4vsa>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6le67q23xsity3tkfq2uazzhwustmqcsqj3talft6qq737hz@dytog6bi4vsa>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2995-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@
 lists.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: A9170327370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 02:51:04PM +0000, Pedro Falcato wrote:
> On Thu, Mar 05, 2026 at 10:50:14AM +0000, Lorenzo Stoakes (Oracle) wrote:
> > On reflection, it's confusing to have vma_flags_test() and
> > vma_desc_test_flags() test whether any comma-separated VMA flag bit is set,
> > while also having vma_flags_test_all() and vma_test_all_flags() separately
> > test whether all flags are set.
> >
> > Firstly, rename vma_flags_test() to vma_flags_test_any() to eliminate this
> > confusion.
>
> Hmm. The names are getting longer. We should fix this One Day.

:) yeha it's a bit of a trade-off still. But for now keeping it (fairly)
straightforward.

>
> >
> > Secondly, since the VMA descriptor flag functions are becoming rather
> > cumbersome, prefer vma_desc_test*() to vma_desc_test_flags*(), and also
> > rename vma_desc_test_flags() to vma_desc_test_any().
>
> >
> > Finally, rename vma_test_all_flags() to vma_test_all() to keep the
> > VMA-specific helper consistent with the VMA descriptor naming convention
> > and to help avoid confusion vs. vma_flags_test_all().
> >
> > While we're here, also update whitespace to be consistent in helper
> > functions.
>
> Extremely amazing patch! you were truly inspired!
>
>
> > Suggested-by: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

:) thanks, I don't know who could have suggested such an amazing idea, well I
won't read the tags to check + spoil the surprise... :>)

>
> --
> Pedro

Cheers, Lorenzo

