Return-Path: <linux-erofs+bounces-3008-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NgJNhEtxGmZwgQAu9opvQ
	(envelope-from <linux-erofs+bounces-3008-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 19:44:33 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883D32AB5B
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 19:44:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgwmr6mXXz2yVB;
	Thu, 26 Mar 2026 05:44:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774464268;
	cv=none; b=XZoIFWZ2Ov2FM5Fhzx/kAF0ET+Cdmfq5pTi6sby0RYOEHXcFFXFPqvJ/K2a/RZIlONOOMgYaR6wK4bJcaYY2gK5qPkOd2IvR7v0EDC00RBQ/X9zHQAqsrWJtMztj7+nu4vPdu70lWivauLIN8hbiqkslMaIofKPYXORWmblxj8bOJw1fzOZ6bAfZsXVfjirdBvDy5cWyBqQqxmjRHA9lCwO3AF8ZdDN0RV1l7CzZFgVj7Ja23pSbt1Rms70CCFS8/mWuRj5qGp0WYT92NepXAG8QpIeMiwsfGYVyzkXsDqJI9/2McJBrMUWw0h9F5B9h/tE/HrtzYnnT24RX+Z3IlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774464268; c=relaxed/relaxed;
	bh=Q4Vizb1B1cpQvvFYrjV9Str+6hi34rpWBD8aY9TqbfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCQo2qKo0dcHHrbspd8UF+4KBoidqpkIoKKl1LnzuBJPYj8OJ+oKXEPzjFnve6o3ZTsHyEHUzLskYA5pig0KzqO/Gca/1jmr+Kkp0dPU0P+N6EIo9FX3wNiuwdRlf2FhJQwW9E7qFh3lZS1W9ZlyidHNCzY0eETZBsh1GN87nuU9fOw622MuAaZF8vXfJk+Ewlspx22/aSadVieaVvjycVSri8acqusr1ZfybhO9pkrchuf5X/i2l1b23LQM9lm/1s5WCN5nvpSWBJUe/jfzra+Hh2QU2jSyu5Yb7y+iyNdk/9nlX73nPBAOCTNCJ5sDKTr/Dvp4uGMRyRqtflpQwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b/v6i8fo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b/v6i8fo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgwmq60jVz2ySc
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 05:44:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 969FE43678;
	Wed, 25 Mar 2026 18:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24946C4CEF7;
	Wed, 25 Mar 2026 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774464265;
	bh=Q4Vizb1B1cpQvvFYrjV9Str+6hi34rpWBD8aY9TqbfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/v6i8fo+vCDTuurUcBJ6vIdUXSzqxb7B/H+jyR7aziWaxChVparkP1xpzHA4L+Kh
	 0+1G6NUJO+VCs044hBHbYry3sea3INNqk7t0OXSop7kK5AFE6+TV1USZMWYfrTWg8j
	 jChBK3dgjXD7onzbUo4rew4EgiAnImaScdAATampyOermEf2S4+tueQT1DEeySLNN7
	 +C1nJXrvxSmvCUSUxc3imsiO1O/XlT+bAFM9byzYzFr3UcRgxYAzPP3U9yE3FGbBEn
	 f3QXzFPLvC1/nhdJGTidMO1E4V+YOCqWwK6fYm8qftH9YVIwmMVgXEjBHRRNEV3si6
	 nbeb1Qgql8q2w==
Date: Wed, 25 Mar 2026 18:44:13 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Tony Luck <tony.luck@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>, 
	Babu Moger <babu.moger@amd.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: always inline __mk_vma_flags() and invoked
 functions
Message-ID: <1ae3915e-19ef-4be0-aa5f-fd66a2e18179@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
 <241f49c52074d436edbb9c6a6662a8dc142a8f43.1772704455.git.ljs@kernel.org>
 <ndtnvnobevdymu5a5tdxdbi4tcsqshs3d6x2vnfgnuclxvgwok@bhbqkzilsets>
 <d352055d-06fe-43b2-8ad3-b73ab99683d0@lucifer.local>
 <20260325090949.795e06f48ec455053db9ae89@linux-foundation.org>
 <959b34ea-69a7-4fda-a494-0b9a1773ec1d@lucifer.local>
 <20260325112755.e62cd89508224f703239f03a@linux-foundation.org>
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
In-Reply-To: <20260325112755.e62cd89508224f703239f03a@linux-foundation.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3008-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:pfalcato@suse.de,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@
 lists.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.de,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_TWELVE(0.00)[44];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5883D32AB5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:27:55AM -0700, Andrew Morton wrote:
> On Wed, 25 Mar 2026 16:23:53 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
>
> > Maybe 'into an inline constant value' is better?
>
> <bikeshedbikeshed>
>
> How about
>
> : Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
> : macro) always being inline, as we rely on the compiler turning all
> : constants into compile-time ones.
>

Well I think that loses the meaning a bit.

Something like:

Be explicit about __mk_vma_flags() (which is used by the mk_vma_flags()
-macro) always being inline, as we rely on the compiler converting this
-function into meaningful.
+macro) always being inline, as we rely on the compiler to evaluate the
+loop in this function and determine that it can replace the code with the
+an equivalent constant value, e.g. that:
+
+__mk_vma_flags(2, (const vma_flag_t []){ VMA_WRITE_BIT, VMA_EXEC_BIT });
+
+Can be replaced with:
+
+(1UL << VMA_WRITE_BIT) | (1UL << VMA_EXEC_BIT)
+
+= (1UL << 1) | (1UL << 2) = 6
+
+Most likely an 'inline' will suffice for this, but be explicit as we can
+be.

Should verbosely cover that off.

Thanks, Lorenzo

