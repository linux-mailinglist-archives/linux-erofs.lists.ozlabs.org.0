Return-Path: <linux-erofs+bounces-2991-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEneBtPAw2kRtwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2991-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 12:02:43 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF0732370B
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 12:02:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgkWy0blvz2xSX;
	Wed, 25 Mar 2026 22:02:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774436558;
	cv=none; b=mBU0EQYvigLWC16XeRsvWcJ1C+YjYHrAiFrF8R5+KxC47uhbeT7dPUAwHF2W41b7fDqAeczECzmsN8flehwhVcn3rH8HQDFeFUQDVaaSddn0CHkpjDQfxAFdMNOdbyJhIl4oeDcUAf5X0WjkCRRwT89c2nfIbKuN7x4BcTISIQvPFzanbmT5nt6XUcELhpid6G9UidtGOq8HXR1ecoO9eZ2Tp71oGTMBkv39xWLLVC0CPKMbWDPrb+CybnpFOC7j6NLzTn7CHSa1d6j10PkARzhF5GmMVuUffsndtYO3Gi2ihymTSLGsqDrzAom+GFQCFy6kzHnPqB6pOwEeqVJxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774436558; c=relaxed/relaxed;
	bh=tHxS02jyuJdc7xck1OGm67X7JRYetEgUpHsHG3XgLZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS/O0YhEq1zcx2yRLuXzaFC55IAVb2w7em9j3A3URELPjH9t5ilZFeI6z9MVEIZAni6mo0IMCtvtbDhZJV9qFWEWNzl3gtLly1SM4A1QxiOjsxUWCJb+1htGMzoSNDpIRApBHY/51tUEutHOn0TR9oBBmnVD7P8/bw4LaE0Rt0y4Z1hpEVa8LJHs/c8hTKE2bDbQjAD8JOLK5POjBJdQgXn2ALeoFw/O8kNEKncPwDvZq1tdsb8H182zgHwCa2DojHpjXSeIaCNkNlz1wlUk3kTNyLlEwwZe1+S4OeyCpgZRfDlxEJz1iPr2V7cVAcFBc7YqvmXlJEbz86Dcg3kklw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JKfbEpL+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JKfbEpL+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgkWx130Rz2xPL
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 22:02:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 10F13600AC;
	Wed, 25 Mar 2026 11:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A3EC2BCB0;
	Wed, 25 Mar 2026 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774436553;
	bh=tHxS02jyuJdc7xck1OGm67X7JRYetEgUpHsHG3XgLZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKfbEpL+QwqITDp7zft06nKiR08zsFI8szKsw2URrZAwiwXqMmi0+tBx1TGvpubXE
	 l1nTkzHyAQbNEBGfQ4nGrX3sKCiFHLJaYrjm5zqZQQQEwtQa6RkpNjHFptlR4PAZ9U
	 IpJ5JeE+RAZ2E9J1YM6Elt355aSIZj/LzRVBQ1/n1qqoMs/OD0sRpg05BMFqsbhi1S
	 Shw3TorVIm0rtJXQ5yVWpZX5z65od1QSnOK7gT/YAbbvBwHnt++ki1xhQcLDAMvu/F
	 g11ayMJaLiBZ/F7XKSiKEpI8doQgK5UkRrJQpjVo/DBAKu4Y4jcyhpVjyAsHbayxPG
	 UmZoSLixBLjOg==
Date: Wed, 25 Mar 2026 11:02:21 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, 
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: add vma_desc_test_all() and use it
Message-ID: <887da31d-96d0-493f-a248-28ae82925c4d@lucifer.local>
References: <cover.1772704455.git.ljs@kernel.org>
 <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
 <d0111a86-7fc9-4e2f-b652-9ecbb894ada5@kernel.org>
 <9203050e-eda6-49a1-97b6-a134da2da313@kernel.org>
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
In-Reply-To: <9203050e-eda6-49a1-97b6-a134da2da313@kernel.org>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2991-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:vbabka@kernel.org,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:pfalcato@suse.de,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@
 lists.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ljs@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,arndb.de,linuxfoundation.org,intel.com,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2AF0732370B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 09:58:53AM +0100, David Hildenbrand (Arm) wrote:
> On 3/25/26 08:31, Vlastimil Babka (SUSE) wrote:
> > On 3/5/26 11:50, Lorenzo Stoakes (Oracle) wrote:
> >> erofs and zonefs are using vma_desc_test_any() twice to check whether all
> >> of VMA_SHARED_BIT and VMA_MAYWRITE_BIT are set, this is silly, so add
> >> vma_desc_test_all() to test all flags and update erofs and zonefs to use
> >> it.
> >>
> >> While we're here, update the helper function comments to be more
> >> consistent.
> >>
> >> Also add the same to the VMA test headers.
> >>
> >> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> >
> > I thought I saw David review all of the series and so focused on other
> > stuff, didn't notice he skipped this one :)
>
> I think I skipped it because it looked too mechanical when scanning and
> I was like "ofc I trust Lorenzo on that one blindly". So I missed to reply.
>
> Tag provided now if it helps.

Thanks guys! Appreciated.

