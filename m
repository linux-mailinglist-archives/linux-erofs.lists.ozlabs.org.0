Return-Path: <linux-erofs+bounces-3003-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEgKKtgIxGk+vgQAu9opvQ
	(envelope-from <linux-erofs+bounces-3003-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 17:10:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C1328BC6
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 17:09:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgsLX14zcz2yTK;
	Thu, 26 Mar 2026 03:09:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774454996;
	cv=none; b=XuwtH76cihv+pcmacAyYa9y+7zM8+ExmU7oZyOVuNIEiuDPhkqs9sWGAdaizoWevoQUQwFC2gN1y0Nzy5enPonMQYo/c9aaUifuvO+z41LSjrg851n1qrBA0ThFYdxsLVmfmmcHyw0o9a1I876iTmP22nq+mZqbZxq4Oj65ZiMs1U2GOYRuZ9ZE0uXlWVEEznSthZx0Vlzg4wmohfU/Iwb8b0fSlVjW82HMGLuQ6/2KwuEcsQekwcHGFOWMB+BsoOORFsm67UkkGxjHkyjrC74rXmq8GgstmX0waZhW21E9jJzMdASc2+K8KCHn2U7y79wTKGvx4OdrffqA/Tp1Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774454996; c=relaxed/relaxed;
	bh=9hvko/myVXBSL3XjUJs7M6eNXPWsG85odKtJdX4y2Yg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Am4AIvKogdQbvw+/0jkJ8sRAYqZZIlOvCA+IcFIv6wKnvxItRyrrp64XVRiRpHH6xYyC+24AMPShC4yR/6ufjZ4ePbLtKtqLGCSAlELCB5tmYTDy+WQwGSTdJBcI+LZzdwbr3/8OYeBbJwZ5HmtIV96/dLII5cgTx2+rFDejooYIl1quMNQHOMxL74pJRQlgFcNGh1zfglAuphrhtnyTqLAKr/fCbd6b/SUYxCF0yrEVp59G1Mc60L9wPceHpwNYpV7iJ+bLZk1Gzw8NYeW3iL85BjiU0GRxJKvVEqB0HUWlD9rkcRTkJivjOhggIdCNV1T+hojxaKM/AgLPg0wemw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=yu2nTqTr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=yu2nTqTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgsLW0mJmz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 03:09:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9CB73600AC;
	Wed, 25 Mar 2026 16:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBA3C4CEF7;
	Wed, 25 Mar 2026 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774454991;
	bh=CpwACGnKbmh8bnL86Y86WsKuJUxg5abhUqwLWbX/48s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yu2nTqTr+4Ixa0aIK77JmVd/k21R9kBHnAAnN62dMDBskTZPMj6ItigXaNiPWYaDN
	 owILDdRj9CR94Ne+mlXhFs0xeZET+j+BL7Wc2PyC7Y5JlWmPDlJwczr1b4LsYZy2nY
	 cP83/jsCsjO9VMlXX+z1yugQE+WA+BNaE8wcuZeA=
Date: Wed, 25 Mar 2026 09:09:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, Hongbo
 Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Tony Luck
 <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, Dave
 Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, Babu Moger
 <babu.moger@amd.com>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
 <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: always inline __mk_vma_flags() and invoked
 functions
Message-Id: <20260325090949.795e06f48ec455053db9ae89@linux-foundation.org>
In-Reply-To: <d352055d-06fe-43b2-8ad3-b73ab99683d0@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
	<241f49c52074d436edbb9c6a6662a8dc142a8f43.1772704455.git.ljs@kernel.org>
	<ndtnvnobevdymu5a5tdxdbi4tcsqshs3d6x2vnfgnuclxvgwok@bhbqkzilsets>
	<d352055d-06fe-43b2-8ad3-b73ab99683d0@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:pfalcato@suse.de,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux
 .dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3003-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[suse.de,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C15C1328BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 14:58:14 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:

> On Wed, Mar 25, 2026 at 02:54:50PM +0000, Pedro Falcato wrote:
> > On Thu, Mar 05, 2026 at 10:50:16AM +0000, Lorenzo Stoakes (Oracle) wrote:
> > > Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
> > > macro) always being inline, as we rely on the compiler converting this
> > > function into meaningful.
> > 		meaningful what?
> 
> 'into the equivalent compile-time constant code' probably fine.
> 
> Andrew - could you update that if there's time?


np


: Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
: macro) always being inline, as we rely on the compiler converting this
: function into the equivalent compile-time constant code.

what does "compile-time constant code" actually mean?  That constants
within the code are evaluated at compile-time?

