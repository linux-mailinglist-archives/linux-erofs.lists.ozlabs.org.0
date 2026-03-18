Return-Path: <linux-erofs+bounces-2829-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDnXFwqFumnrXQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2829-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 11:57:14 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D332BA50A
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 11:57:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbQks08svz2ygT;
	Wed, 18 Mar 2026 21:57:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773831428;
	cv=none; b=V7AnswkjeDq4Yfqs3vonwqezYSVOBT2rCU1IXfnKIN98TRtnwdqT+5KrKcLu7El8pGV49C6/dUATQrl/2OQfg/yg3dteoWAVGZyiukOR/GhGk0+Cu8+xZJiaRiSmnjtRxM1pCb0rrXsJMnC+4fBELwqmrmmBOFj59Fzg5qH78t3Fon1AcW7+Dli74L6N3qlhzrpI/IKlb+XYKkh+6Mxrtja0l1AnJ9zU3yyIyNCf46Fxn8zf2ZqLWSKFlORlQmRFPYspSdm4s0w6iZi6usT2nvdXZMjRQIhHD02b9BAAZp0DAi+LW1pvtCXyKwwHjLoACBOw/EIIGs6bQ60q6cof7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773831428; c=relaxed/relaxed;
	bh=WyyTA2PPT3yZY6uZq8Av3KNKCzdLFfiJWCqyuHjpJpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAkEa1eqaJIJhyFCh75ZCr6JneOcY1LfI5KmHtZL/zE1fPNJoDqoUjVdsOYvf7pZOu86k7Y+GI8F9kukZQBFpDUyGaOKhS3PLmCFH5IGUdRscI/zMD2JCIZRN1zrrjsMqzEhLIYCd4wnPpfXU0d+CspuRO0TMmVQeMeD7oNyBfwR93BRG650NddDzZ3IdMlRavOIri1oZ1mzkSM3rMhtQ7wTj6L+ZvMAvVpqLjw6PmOMuGL4kK7Oy4ZpbaIDtgep4zhc6eawIF/C6UewBZ6yyIZZix0fd3NnDp/6Cb9FrU1bXVAdla2V3TR3NzOPw727Bm3usV86BwbqcF7SdSTyyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CvrVE8BO; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CvrVE8BO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbQkq3rj3z2xlx
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 21:57:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ED13744742;
	Wed, 18 Mar 2026 10:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F8EC19421;
	Wed, 18 Mar 2026 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831422;
	bh=tcfCmK3S2pt4aJtr9Tu11QJn/zIdTDayhGeZCwPth/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvrVE8BO67At/HSXb+xLo8y2NsLBV9EYFZR+ACUUawr+31v1K37an0KaRws+zwKvR
	 Kr2YB0IM+j+xRIbTrZKVK7igfCqkeyhcfKXmsceKdsm6kW4f3roTHl+K3TN8fONbh8
	 EYzy3DxCiz/0iP528EMFE24tt8n061H8ThnljXvXh+rCCXr+W+lgHs/Sc6D5I8rpr1
	 lKsnnBP++HSeanzGJyfyR1IMGrinKL2Rvx/SBUZSzg0dHBThlGuTGZSi4dyrtEXdHy
	 22+dJSlshfTxtomPmCmdGVKB1M1wdiIbmSaNBk233pCcuv4NxgA/zFW/SybPZgERlw
	 ZkrzFm+JTpStA==
Date: Wed, 18 Mar 2026 11:56:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Paul Moore <paul@paul-moore.com>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 1/3] backing_file: store user_path_file
Message-ID: <20260318-einsam-sellerie-2d547dd338ee@brauner>
References: <20260316213606.374109-5-paul@paul-moore.com>
 <20260316213606.374109-6-paul@paul-moore.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316213606.374109-6-paul@paul-moore.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[paul-moore.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-2829-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:amir73il@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C0D332BA50A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 05:35:56PM -0400, Paul Moore wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Instead of storing the user_path, store an O_PATH file for the
> user_path with the original user file creds and a security context.
> 
> The user_path_file is only exported as a const pointer and its refcnt
> is initialized to FILE_REF_DEAD, because it is not a refcounted object.
> 
> The only caller of file_ref_init() is now open coded, so the helper
> is removed.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Tested-by: Paul Moore <paul@paul-moore.com> (SELinux)
> Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com> (EROFS)
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c            | 20 ++++++++------
>  fs/erofs/ishare.c            |  6 ++--
>  fs/file_table.c              | 53 ++++++++++++++++++++++++++++--------
>  fs/fuse/passthrough.c        |  3 +-
>  fs/internal.h                |  5 ++--
>  fs/overlayfs/dir.c           |  3 +-
>  fs/overlayfs/file.c          |  1 +
>  include/linux/backing-file.h | 29 ++++++++++++++++++--
>  include/linux/file_ref.h     | 10 -------
>  9 files changed, 90 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 45da8600d564..acabeea7efff 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/backing-file.h>
>  #include <linux/splice.h>
> +#include <linux/uio.h>
>  #include <linux/mm.h>
>  
>  #include "internal.h"
> @@ -18,9 +19,10 @@
>  /**
>   * backing_file_open - open a backing file for kernel internal use
>   * @user_path:	path that the user reuqested to open
> + * @user_cred:	credentials that the user used for open
>   * @flags:	open flags
>   * @real_path:	path of the backing file
> - * @cred:	credentials for open
> + * @cred:	credentials for open of the backing file
>   *
>   * Open a backing file for a stackable filesystem (e.g., overlayfs).
>   * @user_path may be on the stackable filesystem and @real_path on the
> @@ -29,19 +31,19 @@
>   * returned file into a container structure that also stores the stacked
>   * file's path, which can be retrieved using backing_file_user_path().
>   */
> -struct file *backing_file_open(const struct path *user_path, int flags,
> +struct file *backing_file_open(const struct path *user_path,
> +			       const struct cred *user_cred, int flags,
>  			       const struct path *real_path,
>  			       const struct cred *cred)
>  {
>  	struct file *f;
>  	int error;
>  
> -	f = alloc_empty_backing_file(flags, cred);
> +	f = alloc_empty_backing_file(flags, cred, user_cred);
>  	if (IS_ERR(f))
>  		return f;
>  
> -	path_get(user_path);
> -	backing_file_set_user_path(f, user_path);
> +	backing_file_open_user_path(f, user_path);
>  	error = vfs_open(real_path, f);
>  	if (error) {
>  		fput(f);
> @@ -52,7 +54,8 @@ struct file *backing_file_open(const struct path *user_path, int flags,
>  }
>  EXPORT_SYMBOL_GPL(backing_file_open);
>  
> -struct file *backing_tmpfile_open(const struct path *user_path, int flags,
> +struct file *backing_tmpfile_open(const struct path *user_path,
> +				  const struct cred *user_cred, int flags,
>  				  const struct path *real_parentpath,
>  				  umode_t mode, const struct cred *cred)
>  {
> @@ -60,12 +63,11 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
>  	struct file *f;
>  	int error;
>  
> -	f = alloc_empty_backing_file(flags, cred);
> +	f = alloc_empty_backing_file(flags, cred, user_cred);
>  	if (IS_ERR(f))
>  		return f;
>  
> -	path_get(user_path);
> -	backing_file_set_user_path(f, user_path);
> +	backing_file_open_user_path(f, user_path);
>  	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
>  	if (error) {
>  		fput(f);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 829d50d5c717..17a4941d4518 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -106,15 +106,15 @@ static int erofs_ishare_file_open(struct inode *inode, struct file *file)
>  
>  	if (file->f_flags & O_DIRECT)
>  		return -EINVAL;
> -	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
> +	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred(),
> +					    file->f_cred);
>  	if (IS_ERR(realfile))
>  		return PTR_ERR(realfile);
>  	ihold(sharedinode);
>  	realfile->f_op = &erofs_file_fops;
>  	realfile->f_inode = sharedinode;
>  	realfile->f_mapping = sharedinode->i_mapping;
> -	path_get(&file->f_path);
> -	backing_file_set_user_path(realfile, &file->f_path);
> +	backing_file_open_user_path(realfile, &file->f_path);
>  
>  	file_ra_state_init(&realfile->f_ra, file->f_mapping);
>  	realfile->private_data = EROFS_I(inode);
> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..b7dc94656c44 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -27,6 +27,7 @@
>  #include <linux/task_work.h>
>  #include <linux/swap.h>
>  #include <linux/kmemleak.h>
> +#include <linux/backing-file.h>
>  
>  #include <linux/atomic.h>
>  
> @@ -43,11 +44,11 @@ static struct kmem_cache *bfilp_cachep __ro_after_init;
>  
>  static struct percpu_counter nr_files __cacheline_aligned_in_smp;
>  
> -/* Container for backing file with optional user path */
> +/* Container for backing file with optional user path file */
>  struct backing_file {
>  	struct file file;
>  	union {
> -		struct path user_path;
> +		struct file user_path_file;
>  		freeptr_t bf_freeptr;
>  	};
>  };
> @@ -56,24 +57,44 @@ struct backing_file {
>  
>  const struct path *backing_file_user_path(const struct file *f)
>  {
> -	return &backing_file(f)->user_path;
> +	return &backing_file(f)->user_path_file.f_path;
>  }
>  EXPORT_SYMBOL_GPL(backing_file_user_path);
>  
> -void backing_file_set_user_path(struct file *f, const struct path *path)
> +const struct file *backing_file_user_path_file(const struct file *f)
>  {
> -	backing_file(f)->user_path = *path;
> +	return &backing_file(f)->user_path_file;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_user_path_file);
> +
> +void backing_file_open_user_path(struct file *f, const struct path *path)

I think this is a bad idea. This should return an error but still
WARN_ON(). Just make callers handle that error just like we do
everywhere else.

> +{
> +	/* open an O_PATH file to reference the user path - cannot fail */
> +	WARN_ON(vfs_open(path, &backing_file(f)->user_path_file));
> +}
> +EXPORT_SYMBOL_GPL(backing_file_open_user_path);
> +
> +static void destroy_file(struct file *f)
> +{
> +	security_file_free(f);
> +	put_cred(f->f_cred);

Note that calling destroy_file() in this way bypasses
security_file_release(). Presumably this doesn't matter because no LSM
does a security_alloc_file() for this but it adds a nother wrinkly into
the cleanup path.


>  }
> -EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>  
>  static inline void file_free(struct file *f)
>  {
> -	security_file_free(f);
> +	destroy_file(f);
>  	if (likely(!(f->f_mode & FMODE_NOACCOUNT)))
>  		percpu_counter_dec(&nr_files);
> -	put_cred(f->f_cred);
>  	if (unlikely(f->f_mode & FMODE_BACKING)) {
> -		path_put(backing_file_user_path(f));
> +		struct file *user_path_file = &backing_file(f)->user_path_file;
> +
> +		/*
> +		 * no refcount on the user_path_file - they die together,
> +		 * so __fput() is not called for user_path_file. path_put()
> +		 * is the only relevant cleanup from __fput().
> +		 */
> +		destroy_file(user_path_file);
> +		path_put(&user_path_file->__f_path);
>  		kmem_cache_free(bfilp_cachep, backing_file(f));
>  	} else {
>  		kmem_cache_free(filp_cachep, f);
> @@ -201,7 +222,7 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	 * fget-rcu pattern users need to be able to handle spurious
>  	 * refcount bumps we should reinitialize the reused file first.
>  	 */
> -	file_ref_init(&f->f_ref, 1);
> +	atomic_long_set(&f->f_ref.refcnt, FILE_REF_ONEREF);

No, please don't open-code this. The point is to stop any open-access to
f_ref. And also below you introduce another atomic_long_set() open-coded
call as well. Simply adapt file_ref_init() to not do the -1 subtraction
and use the constants directly.

>  	return 0;
>  }
>  
> @@ -290,7 +311,8 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
>   * This is only for kernel internal use, and the allocate file must not be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred,
> +				      const struct cred *user_cred)
>  {
>  	struct backing_file *ff;
>  	int error;
> @@ -305,6 +327,15 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
>  		return ERR_PTR(error);
>  	}
>  
> +	error = init_file(&ff->user_path_file, O_PATH, user_cred);
> +	/* user_path_file is not refcounterd - it dies with the backing file */
> +	atomic_long_set(&ff->user_path_file.f_ref.refcnt, FILE_REF_DEAD);

Please massage this and send that patch. I'll stuff it into a stable vfs
branch that both Paul and I can merge. Paul can then send his PR.

