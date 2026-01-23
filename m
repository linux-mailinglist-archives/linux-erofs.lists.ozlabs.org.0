Return-Path: <linux-erofs+bounces-2208-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDZ8EVgTc2lksAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2208-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:21:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BC70D56
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:21:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy79K0Bp2z2xKh;
	Fri, 23 Jan 2026 17:21:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769149269;
	cv=none; b=CeNoSBgalrckDSvPrNWetfQm1WxEPSUtIsSvhIVzH60+90M5g6MFnHKCQpq9/ChZ5pSn+RkzX9mYda3fsK92al9mAFXGMRSXNGnT6514hiTHc1BgaFc06o9slbyDEVDy/HNrpcabpL0asdiWvVlpoCCJAxM1RWWFKkCleKusH44XH2oXFALy1I4nXaXEXPwpEmfTmZyeelZ5YAHwpT9d6nXnQYgbwJy8hfKvFfE9i9yIorY2+gg5NSUqwKANIpsKeQDW0FIRaX2wlnxp9xy7jgfQeMl2Mwt5aVUE3Fim+8mu4TnNLh4VISpq7j0QZPLeIS/7ULL+FcT40Pr53a2YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769149269; c=relaxed/relaxed;
	bh=1870OwY7Yt3wtHMS4Kw5+Uzzq7JdVz48VXgwCaXXTJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrZES1FQ0T8+Q7NJTKolc57u9H891pR7sw4XxGWQ2fYqmLztrg0wlC7Vl8xHLgWQ1oGk2KwkjsG9kxzCIpZdsLGQ29lFMFQRAHYANlXkgMVOZnaECpkcDLtn6d6hwI0FykTC3kKu0v3ptkFYCOcHgzKOwZdY/mrvsE4N/peuLEJiBD9d4HVJ6AglN0W9OTwMXb0M5ew4sGSVa0h0whUY41wW0I0Fp1fClKkpmY7AP3WrIGAFbeJPJWM20Sm11bfUbqGkK969xRMlwKFl+ZO/fXSo7NxRUe/SNkVwHwjecJL8Koed4G8QU62D9/vywjQvDjre9BUhXelSpMvwlwX4CQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kg2JYkB+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=kg2JYkB+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy79C5gn5z2xJ5
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 17:21:01 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769149256; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1870OwY7Yt3wtHMS4Kw5+Uzzq7JdVz48VXgwCaXXTJw=;
	b=kg2JYkB+j/klxwL3UO5QTCKzX/ujs83Gl0PHjcFks/lHE1Sf7P1Nfw0LEs1B/mb84a9xcFJ18gcgdO3XSO/dF8oIIbj6X5roDcQpioTShk5mBDS77I4ScxxH/x6xpekifDrYGVBbN+80dK/5MrA+4h6g1JmG3Xd0yIGUXrLcZQ4=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WxemimV_1769149254 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 14:20:54 +0800
Message-ID: <7ccc3447-3a39-4206-95c5-a6cd00e2bda6@linux.alibaba.com>
Date: Fri, 23 Jan 2026 14:20:51 +0800
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
Subject: Re: [PATCH v2 08/13] mm: update shmem_[kernel]_file_*() functions to
 use vma_flags_t
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, ntfs3@lists.linux.dev, devel@lists.orangefs.org,
 linux-xfs@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <cover.1769097829.git.lorenzo.stoakes@oracle.com>
 <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <736febd280eb484d79cef5cf55b8a6f79ad832d2.1769097829.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2208-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:lorenzo.stoakes@oracle.com,m:akpm@linux-foundation.org,m:x86@kernel.org,m:linux-sgx@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-aio@kvack.org,m:linux-erofs@lists.ozlabs.org,m:linux-ext4@vger.kernel.org,m:linux-mm@kvack.org,m:ntfs3@lists.linux.dev,m:devel@lists.orangefs.org,m:linux-xfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.974];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 444BC70D56
X-Rspamd-Action: no action



On 1/23/26 12:06 AM, Lorenzo Stoakes wrote:
> In order to be able to use only vma_flags_t in vm_area_desc we must adjust
> shmem file setup functions to operate in terms of vma_flags_t rather than
> vm_flags_t.
> 
> This patch makes this change and updates all callers to use the new
> functions.
> 
> No functional changes intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

(reduced distribution list too)

Thanks. The shmem part looks good to me with some nits below.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/x86/kernel/cpu/sgx/ioctl.c           |  2 +-
>   drivers/gpu/drm/drm_gem.c                 |  5 +-
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c   |  3 +-
>   drivers/gpu/drm/i915/gt/shmem_utils.c     |  3 +-
>   drivers/gpu/drm/ttm/tests/ttm_tt_test.c   |  2 +-
>   drivers/gpu/drm/ttm/ttm_backup.c          |  3 +-
>   drivers/gpu/drm/ttm/ttm_tt.c              |  2 +-
>   fs/xfs/scrub/xfile.c                      |  3 +-
>   fs/xfs/xfs_buf_mem.c                      |  2 +-
>   include/linux/shmem_fs.h                  |  8 ++-
>   ipc/shm.c                                 |  6 +--
>   mm/memfd.c                                |  2 +-
>   mm/memfd_luo.c                            |  2 +-
>   mm/shmem.c                                | 59 +++++++++++++----------
>   security/keys/big_key.c                   |  2 +-
>   16 files changed, 57 insertions(+), 49 deletions(-)

[snip]

>   	inode->i_flags |= i_flags;
> @@ -5864,9 +5869,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>    *	checks are provided at the key or shm level rather than the inode.
>    * @name: name for dentry (to be seen in /proc/<pid>/maps)
>    * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @vma_flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size

nit: s/vma_flags/flags

>    */
> -struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_kernel_file_setup(const char *name, loff_t size,
> +				     vma_flags_t flags)
>   {
>   	return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
>   }
> @@ -5878,7 +5884,7 @@ EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
>    * @size: size to be set for the file
>    * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size

nit: s/VM_NORESERVE/VMA_NORESERVE_BIT

>    */
> -struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
> +struct file *shmem_file_setup(const char *name, loff_t size, vma_flags_t flags)
>   {
>   	return __shmem_file_setup(shm_mnt, name, size, flags, 0);
>   }
> @@ -5889,16 +5895,17 @@ EXPORT_SYMBOL_GPL(shmem_file_setup);
>    * @mnt: the tmpfs mount where the file will be created
>    * @name: name for dentry (to be seen in /proc/<pid>/maps)
>    * @size: size to be set for the file
> - * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
> + * @flags: VMA_NORESERVE_BIT suppresses pre-accounting of the entire object size
>    */
>   struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
> -				       loff_t size, unsigned long flags)
> +				       loff_t size, vma_flags_t flags)
>   {
>   	return __shmem_file_setup(mnt, name, size, flags, 0);
>   }
>   EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
>   
> -static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
> +static struct file *__shmem_zero_setup(unsigned long start, unsigned long end,
> +		vma_flags_t flags)
>   {
>   	loff_t size = end - start;
>   
> @@ -5908,7 +5915,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>   	 * accessible to the user through its mapping, use S_PRIVATE flag to
>   	 * bypass file security, in the same way as shmem_kernel_file_setup().
>   	 */
> -	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
> +	return shmem_kernel_file_setup("dev/zero", size, flags);
>   }
>   
>   /**
> @@ -5918,7 +5925,7 @@ static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, v
>    */
>   int shmem_zero_setup(struct vm_area_struct *vma)
>   {
> -	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
> +	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->flags);
>   
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
> @@ -5939,7 +5946,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
>    */
>   int shmem_zero_setup_desc(struct vm_area_desc *desc)
>   {
> -	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
> +	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vma_flags);
>   
>   	if (IS_ERR(file))
>   		return PTR_ERR(file);
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index d46862ab90d6..268f702df380 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -103,7 +103,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
>   					 0, enckey);
>   
>   		/* save aligned data to file */
> -		file = shmem_kernel_file_setup("", enclen, 0);
> +		file = shmem_kernel_file_setup("", enclen, EMPTY_VMA_FLAGS);
>   		if (IS_ERR(file)) {
>   			ret = PTR_ERR(file);
>   			goto err_enckey;


