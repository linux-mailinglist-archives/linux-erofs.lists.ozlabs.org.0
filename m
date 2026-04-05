Return-Path: <linux-erofs+bounces-3202-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDPlM9yq0WlUMQcAu9opvQ
	(envelope-from <linux-erofs+bounces-3202-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 02:20:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34CB39CEFB
	for <lists+linux-erofs@lfdr.de>; Sun, 05 Apr 2026 02:20:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fpCm31D1Lz2xSB;
	Sun, 05 Apr 2026 10:20:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:121:463::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775348435;
	cv=none; b=FGX90Y/68zGM3GbAUyaAVXooHlrrHmlbVFfWU93Am3te48Q0fEOiaNOZ9MvztvQYnqKwBZmjT4+aaoV2uE1e09CLrrSaH1gJ5tDO1E51eMy2XCAw2Dk0A72R4V96mZ/T6uN1wsDpgJbSE/RI4zAN9kL6gBlMjad39OubmV235MgapHndawvAa1wsvDtb+ft89Z9uSjJ9DMH8jhzMXj3TADXB2aPo/XzT/9EEx9xYRzsD2Mcs3oWrC44V7RzFnPItd/RofwNC4w72aKfPcb9b/5XnPc8ShnYud6dT3O5zVOZIw+sgUWucKO4DE7DJJQ830U+SoHGCbUsqUhmpqgyOng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775348435; c=relaxed/relaxed;
	bh=v7nO/n0ZYZhX9BAonuzAKUuELV2P2TOnc8ye3PeY0EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIvhyI+B7N78fqAX/wHicPknFqeVblQci21tgKwv7nKNie1fYlwqmfbbBj1xRVzHw2xTfUzyAK0XtWEZCdD1A+f6kWYKc8DxLcziUYOIHu2DUibLZpv1S1SF3BBxR49zDdoLpBbI91nx3X6hh0xBL7smalZe4MojY7mN5wg5qgwR5sicr1l9DnouO0X3PRXpfsmWLfcWQesKSmJ8k8qluRVTZ+oDfmiuZ5SZePS1lvYJQOA/n1InllbP6awlDpiXxuu9ELi5JL99WqjjjZ916EGoSGCjKQZjlox2ElyKb4uB7RKzlAIVcOtDKtVDjtLTBxeDvkZ76UMGqD6j4SmNwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; dkim=pass (2048-bit key; unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=JWx5eE7y; dkim-atps=neutral; spf=permerror (client-ip=2a01:4f8:121:463::2; helo=mail.hallyn.com; envelope-from=serge@mail.hallyn.com; receiver=lists.ozlabs.org) smtp.mailfrom=mail.hallyn.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=JWx5eE7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=mail.hallyn.com (client-ip=2a01:4f8:121:463::2; helo=mail.hallyn.com; envelope-from=serge@mail.hallyn.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 334 seconds by postgrey-1.37 at boromir; Sun, 05 Apr 2026 10:20:32 AEST
Received: from mail.hallyn.com (unknown [IPv6:2a01:4f8:121:463::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fpCm06F9Rz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sun, 05 Apr 2026 10:20:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1775348090; bh=1M98P8mdYJW4I2V6XU2SgcYoy/bp2xwGEJ5KRJ50rsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWx5eE7yenS6sq7NkiQgi/5cVTmFPcjtbwdP8cYDq84gGQMG87c06OW5bwzuclVkY
	 Zrj923lqzDEua8afDEVqUOTXc61xJLO9lNEzNdJWXwYZs/hDH4Ukw9Kr4BAClHanNe
	 zmKgAeWh69GKn9nHaGZhmUSftu7fTt+KCEmdHE2OfP/AoyQ8a4O/XASJBfsbg7gYtN
	 S1m/B2m9kYdAhIMKBYBJ6qlc+Z/BI6oFGAhWMAmwHiG0s22z3CPHdBM2cU1njqYigz
	 nqTwd6YB9yK5EWu/i38RdaSNsjAj1mtL+56BWUtqbc9pT3J3NW5LUw5rYKfxHq7A8Q
	 MXE4YFdPUNcew==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D198A48B; Sat,  4 Apr 2026 19:14:50 -0500 (CDT)
Date: Sat, 4 Apr 2026 19:14:50 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/3] fs: prepare for adding LSM blob to backing_file
Message-ID: <adGpei4WQ3Btvvrl@mail.hallyn.com>
References: <20260403030848.731867-5-paul@paul-moore.com>
 <20260403030848.731867-6-paul@paul-moore.com>
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
In-Reply-To: <20260403030848.731867-6-paul@paul-moore.com>
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
	autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hallyn.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[hallyn.com:s=mail];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3202-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[serge@hallyn.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hallyn.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serge@hallyn.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:dkim,hallyn.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D34CB39CEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 11:08:33PM -0400, Paul Moore wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> In preparation to adding LSM blob to backing_file struct, factor out
> helpers init_backing_file() and backing_file_free().
> 
> Cc: stable@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-erofs@lists.ozlabs.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> [PM: use the term "LSM blob", fix comment style to match file]
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  fs/file_table.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..3b3792903185 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -66,6 +66,12 @@ void backing_file_set_user_path(struct file *f, const struct path *path)
>  }
>  EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>  
> +static inline void backing_file_free(struct backing_file *ff)
> +{
> +	path_put(&ff->user_path);
> +	kmem_cache_free(bfilp_cachep, ff);
> +}
> +
>  static inline void file_free(struct file *f)
>  {
>  	security_file_free(f);
> @@ -73,8 +79,7 @@ static inline void file_free(struct file *f)
>  		percpu_counter_dec(&nr_files);
>  	put_cred(f->f_cred);
>  	if (unlikely(f->f_mode & FMODE_BACKING)) {
> -		path_put(backing_file_user_path(f));
> -		kmem_cache_free(bfilp_cachep, backing_file(f));
> +		backing_file_free(backing_file(f));
>  	} else {
>  		kmem_cache_free(filp_cachep, f);
>  	}
> @@ -283,6 +288,12 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
>  	return f;
>  }
>  
> +static int init_backing_file(struct backing_file *ff)
> +{
> +	memset(&ff->user_path, 0, sizeof(ff->user_path));
> +	return 0;
> +}
> +
>  /*
>   * Variant of alloc_empty_file() that allocates a backing_file container
>   * and doesn't check and modify nr_files.
> @@ -305,7 +316,14 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
>  		return ERR_PTR(error);
>  	}
>  
> +	/* The f_mode flags must be set before fput(). */
>  	ff->file.f_mode |= FMODE_BACKING | FMODE_NOACCOUNT;
> +	error = init_backing_file(ff);
> +	if (unlikely(error)) {
> +		fput(&ff->file);
> +		return ERR_PTR(error);
> +	}
> +
>  	return &ff->file;
>  }
>  EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
> -- 
> 2.53.0
> 

