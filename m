Return-Path: <linux-erofs+bounces-2982-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAfWJ1GPw2mCrgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2982-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 08:31:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515F320B97
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 08:31:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgdrF1GFzz2xMQ;
	Wed, 25 Mar 2026 18:31:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774423885;
	cv=none; b=mhkkdH/8zpv1zZTvg32ihmOrpXmxRQPN8hiQqmYC7zhp5/xiSV1brl/FkpaeiZDr9O38y944GhNNt8eqMrWbMvabYFSmuockwk6zzhxAOgPUyFNcuuXYde6F2AFeJMjOL7QdwICYXGSzFMWS2LTpbcJX6axJn6SF0G/7ie6QHpdWfSQWvMQVNl1jEG+Ltsha8JAtgab1PVZW9OPIrClUwPbOfKn+ZJA3RpVTE4qHWXb1sUe0L3kjckastLCOHNuJ209r20MN39iFCa4roO4ko8zFXQt4lyHYvf838vJxPO1BbMPx9pEv3jwqCKGL0f592RKFsedn0nvT+vrZ0SDTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774423885; c=relaxed/relaxed;
	bh=U01UvLL+2GKumhMfccsBdT4HdxsnM5GOcch+EONw0Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5m1R1vUzXD6OFyP5i/b5fOFGFqjXwXwn0rk/wHFeBp4g+C++vllAkrz7ZoB+f+EEzKSG2TH+oj8uqkcz27R175ainaFz2zVarcjZuy52UlGO35dqX7W/3hfV2MS8+TNgfXHDJH4LYX2Ps0g149jQ7PSNKVjxJSYPUTTHvJdxNDYlrP2Pf59XWGSzaD6TteKAV4rxe0t0dwQnOfO6UKDzLJfaELuHVUIDI1yDSwkUpcx5wfTrmcx7lMBJnVzHwxXClIWZpZendgU6B77NQgLYmVPwivfSlHykXP7vdzAtKUxDSiaLE5NVlvSwDdOP6fTdqV23zNpTvaZAEPskIwfmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nQ1tBcxS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nQ1tBcxS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgdrD0vlJz2xLv
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 18:31:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 31B99600AC;
	Wed, 25 Mar 2026 07:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BAAC4CEF7;
	Wed, 25 Mar 2026 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423880;
	bh=PDpC05xIR6s/4UV5jN3PjFOdu2Q97pVq9psWfxYFyHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nQ1tBcxSm01q4n6kTNrYWBbiz6PEozKBxiLI/zRRn9IVJLOFBuiCTBZTV6Ycbv68o
	 oiWSh5L8g+RNHWwPtdhmgn1oKV6wvxKTmlFbkJn31BymWvwaLcilghpF/Kt/e22P+q
	 To61pHOGS02rXG/sHWxWWIOLGtCXLJBQT+6jZQNKx4kBXkP5f8DvFEMIKhLfbKwCRz
	 8lqFvmWOowscszEiyhGCEjWBxzBqyWA5PR4f3CAd2qIwYN8saFjOzhVIqCVJoXxKNz
	 TPC4R2t+1iEuQeBDdvvuzwc1kVUBP5vhdKl/eZDomHm8OIwC74J3M9QLLUmopfkeUj
	 a2GPHfKz7cfEA==
Message-ID: <d0111a86-7fc9-4e2f-b652-9ecbb894ada5@kernel.org>
Date: Wed, 25 Mar 2026 08:31:09 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] mm: add vma_desc_test_all() and use it
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <cover.1772704455.git.ljs@kernel.org>
 <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <568c8f8d6a84ff64014f997517cba7a629f7eed6.1772704455.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-2982-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:pfalcato@suse.de,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@lis
 ts.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vbabka@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1515F320B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/5/26 11:50, Lorenzo Stoakes (Oracle) wrote:
> erofs and zonefs are using vma_desc_test_any() twice to check whether all
> of VMA_SHARED_BIT and VMA_MAYWRITE_BIT are set, this is silly, so add
> vma_desc_test_all() to test all flags and update erofs and zonefs to use
> it.
> 
> While we're here, update the helper function comments to be more
> consistent.
> 
> Also add the same to the VMA test headers.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

I thought I saw David review all of the series and so focused on other
stuff, didn't notice he skipped this one :)

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  fs/erofs/data.c                 |  3 +--
>  fs/zonefs/file.c                |  3 +--
>  include/linux/mm.h              | 24 ++++++++++++++++++++----
>  tools/testing/vma/include/dup.h |  9 +++++++++
>  4 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 6774d9b5ee82..b33dd4d8710e 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -473,8 +473,7 @@ static int erofs_file_mmap_prepare(struct vm_area_desc *desc)
>  	if (!IS_DAX(file_inode(desc->file)))
>  		return generic_file_readonly_mmap_prepare(desc);
>  
> -	if (vma_desc_test_any(desc, VMA_SHARED_BIT) &&
> -	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
> +	if (vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
>  		return -EINVAL;
>  
>  	desc->vm_ops = &erofs_dax_vm_ops;
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 9f9273ecf71a..5ada33f70bb4 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -333,8 +333,7 @@ static int zonefs_file_mmap_prepare(struct vm_area_desc *desc)
>  	 * ordering between msync() and page cache writeback.
>  	 */
>  	if (zonefs_inode_is_seq(file_inode(file)) &&
> -	    vma_desc_test_any(desc, VMA_SHARED_BIT) &&
> -	    vma_desc_test_any(desc, VMA_MAYWRITE_BIT))
> +	    vma_desc_test_all(desc, VMA_SHARED_BIT, VMA_MAYWRITE_BIT))
>  		return -EINVAL;
>  
>  	file_accessed(file);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db738a567637..9a052eedcdf4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1178,7 +1178,7 @@ static inline void vma_set_flags_mask(struct vm_area_struct *vma,
>  #define vma_set_flags(vma, ...) \
>  	vma_set_flags_mask(vma, mk_vma_flags(__VA_ARGS__))
>  
> -/* Helper to test all VMA flags in a VMA descriptor. */
> +/* Helper to test any VMA flags in a VMA descriptor. */
>  static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
>  		vma_flags_t flags)
>  {
> @@ -1186,8 +1186,8 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
>  }
>  
>  /*
> - * Helper macro for testing VMA flags for an input pointer to a struct
> - * vm_area_desc object describing a proposed VMA, e.g.:
> + * Helper macro for testing whether any VMA flags are set in a VMA descriptor,
> + * e.g.:
>   *
>   * if (vma_desc_test_any(desc, VMA_IO_BIT, VMA_PFNMAP_BIT,
>   *		VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT)) { ... }
> @@ -1195,6 +1195,22 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
>  #define vma_desc_test_any(desc, ...) \
>  	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
>  
> +/* Helper to test all VMA flags in a VMA descriptor. */
> +static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
> +		vma_flags_t flags)
> +{
> +	return vma_flags_test_all_mask(&desc->vma_flags, flags);
> +}
> +
> +/*
> + * Helper macro for testing whether ALL VMA flags are set in a VMA descriptor,
> + * e.g.:
> + *
> + * if (vma_desc_test_all(desc, VMA_READ_BIT, VMA_MAYREAD_BIT)) { ... }
> + */
> +#define vma_desc_test_all(desc, ...) \
> +	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
>  /* Helper to set all VMA flags in a VMA descriptor. */
>  static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
>  		vma_flags_t flags)
> @@ -1207,7 +1223,7 @@ static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
>   * vm_area_desc object describing a proposed VMA, e.g.:
>   *
>   * vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> - * 		VMA_DONTDUMP_BIT);
> + *		VMA_DONTDUMP_BIT);
>   */
>  #define vma_desc_set_flags(desc, ...) \
>  	vma_desc_set_flags_mask(desc, mk_vma_flags(__VA_ARGS__))
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> index c46b523e428d..59788bc14d75 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -922,6 +922,15 @@ static inline bool vma_desc_test_any_mask(const struct vm_area_desc *desc,
>  #define vma_desc_test_any(desc, ...) \
>  	vma_desc_test_any_mask(desc, mk_vma_flags(__VA_ARGS__))
>  
> +static inline bool vma_desc_test_all_mask(const struct vm_area_desc *desc,
> +		vma_flags_t flags)
> +{
> +	return vma_flags_test_all_mask(&desc->vma_flags, flags);
> +}
> +
> +#define vma_desc_test_all(desc, ...) \
> +	vma_desc_test_all_mask(desc, mk_vma_flags(__VA_ARGS__))
> +
>  static inline void vma_desc_set_flags_mask(struct vm_area_desc *desc,
>  					   vma_flags_t flags)
>  {


