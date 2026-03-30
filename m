Return-Path: <linux-erofs+bounces-3111-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL5qEPY1ymkx6gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3111-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:36:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A867357432
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 10:36:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkl2V4k9dz2xpt;
	Mon, 30 Mar 2026 19:36:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774859762;
	cv=pass; b=oW6G9UCjQovzjUt2K8jCN5cfT54EKZqT7/xThcZDfhG2HrS6TYcDkfBT3MKACRGpvRDe1PlPkQXITL9MtdDhAaP56STRTIkgMuT4y02vcBB4263GT9DTxZ7OOlOAaSz3G7nz5xs9L977TfDjipojuiRxEKXGwXleMVTR66ahWH1z13GS0J2BGT4LnYrQMRRXNRmBGoAm3Pf9ER+vSxeTpL85MAvGoT2QKSLGrx8k/uvQH1YpgpmjKRBqVweUNQInQ7y3KwZyk29Wi+DUV1cJA7taTWi+hhRxbjC6WqAEafy+JooLqKXN2X0tBF8dr4yIQpSwFyymg9HypGLvwgVvJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774859762; c=relaxed/relaxed;
	bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOuCIkhihEmlbG3oY9h3DMpbfVFKPXSwNf9lGa4IPWDqu4WgcNH7wmMdabEjfKzIUVYMu8CwT+VN4zs3+UW4B+Ef8nrNqzhWZ1l7SAaJkvzcgsbf90GbRvg1c9x42Dul6eW6yIdJG2EvfYSkEqQtd/7kwg8mvA1atpk0Dg6Z2rj15VFYkXZQDHO/RRC+ky2PxDSHGIgk2xMCW1IbeQgMqyvtHglFS5jgPs49eGmp4c7XV0zsDABLREVnTepa1Qz1UyLbsIFzD9vFQlxn07hmG1tO48bXGLAlHdTO+GFh7JI680Y6V2pHmOrc++0I8Me8htFkiZiy497BLB3bmLuKXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AkWExhoj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AkWExhoj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkl2T1DdKz2xlK
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:36:00 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso885484a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 01:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859756; cv=none;
        d=google.com; s=arc-20240605;
        b=ZxMETF4GTFCtCziFau5q1fI4PwLgfvvPfQDoVh9G8vA9n/sEkfbPJr8VY5ttYBadEg
         h+ed/HKjxE2H2L0DMqKbnwAqQFcPSkemvljrh7ki6K0gayRHqlE/lCuJvoQPqaLoqEyK
         8hiWzOwAH6OM1iERF3A1XbVl0j8IJ58wEyOCNVjCFVsXSYEA2eECssd/Wc+jNQltDWtH
         N2OZ2dl5NIvBdmQf1g3z3CBr8dGhzcOb3DZybX0GU4dHjjr6KT1oWfycIX8odER1y3+T
         Ip2Obq6bnMS/WuRdv1uWxs7S3+yn9HuvdtguoiDVuOmYu/C/0SfAHsh5rS9hbkkQ+s4+
         3yXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        fh=0rhMG/baBV6MiZ18p1njIVdAYqpCw8r0PWala2iSJd4=;
        b=U0gWP53oHyg6syqslb3WCzq1Y3cw4bFDbCJORGXEcKrOkIRqaykX49OErATnMaOysb
         TIXKLGV8WdtV6tscQPBG3vi0//8nBtniVjrs5aioAmLUpihsg8ALSUoFmf3km8NHVLpa
         bM/Zy1xZJczwswzcKYZHeWr5s1XHU6YxRhSx4LZhTxnI0wPHJRAGrL1gan/xzfkfpb4G
         zZxEOC/kBeUZXl4Mv/FCKsd+HpxWJS50VGmkXMQOsiT4yUpmT6cGZs33D37Kj6mjQKbE
         RYFwybxlgbsJ10euSuGbRaurSGpxK7HzMwJULrkEq2K9+89ly5aQ1GfU6PhW3VfkLHjg
         C7Ew==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859756; x=1775464556; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        b=AkWExhoj2L6xkRS2jBLiCwU5BHcVfb4niZvv5cnPupBt9Mowl4D42akrLFTtcxox4I
         JiveEwgPCFhsvnSYUUS2xTHYnBu8/D8Ov5IDXjb+bEXYa4C+lQQNsPHk0gsqxlZFUPSz
         Vl7ckPtvP87m81VWnxqaBac6PHIIHOsEAILWlThwXIaHsw6Df2uMBz4Y3P/warnuBd41
         ooBktqUJiaPtVGQVGhP5+rI7KELtwdR9SeqguDUNWC62ogmZmrn8wy8k4AueJbMTAK/I
         UG/MxGIhHQTLr2CsKFHQFR69qos8Y3Hs0DHQQuMOzpzRm3Jn5AI6F18mTHbwHUb0Eat3
         CUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859756; x=1775464556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        b=Hf1VONFOGlHmOMWX7DhpelD2uhcR3pIpMNWwOIe70ce6SKk/nwhn6AXbbfKxb1rAK7
         EFskAMa0KnIqhK0gmEMadSqyBRxP851riZPjwfVKKrrpoXuKFPh9MgJ6+dHXA2YJzAm1
         Ua09t1UStEucxcdUQI8B0frBXgPBbUGb49jt4DsvC1O36SM9xXGFb/naNonOBRY6boGF
         NeF8AXsykgdtTz8hLaJrKD2p3QUz/i1ww5yPctAuMxxf+ddgBdzmp5b2e1sJgLRACbtt
         kiiKjmDKcFbaUFK2fMS9fOzL1KmBSxnBiXdCYcNo+EPaBzTp6/vp1yh27KAMWARkXMYe
         nBjw==
X-Forwarded-Encrypted: i=1; AJvYcCU31XRLOLD7aM2Q4nQi2k8h8y0B2QywhJrXWOGdzDzQ3+K3y7MU/jYPZH3WaM91Jei/BZ+sjx2+rH4f3w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKGeeXcvvo+3KPSGPQNhNyYNtgOiAju5cCev6s7EEHAxaoO42V
	R1E+/dKyPe2D08FyC6ZEWsOl8XEDjqAcZsk/w7eeTY+pO0qo5m2WFKb6Z/Ni3HGDHXEYnQGkNoc
	c+IEyF/cy1beeQewtzR+otLOT9cuEvOs=
X-Gm-Gg: ATEYQzy9Pk1k7a0y6OYq/crLyZpjYAet/DXTSJfCVEtMdWqWBVW44Zp7vuRU+V5pv1c
	4Ed35muXXYCrIjgZo2rq145BrncnawILRRgo+PcHVkKS6i+YHI/eeu3gxMyKixnK1mpLGyMSlNg
	UeOmuAuHmC+LDMuXgZJutBpfez9+7Bf7hCRoKhE0gsfLEBXGOFK/CCrU8lbq66BLHS/ItWvp76H
	squnCi0S7Sqkt0blv8R0nylUatQAx57RitQufdOARN5KtF3PgUY2ENrx1xcOg6ThDfDQzQc5EnK
	cLwZc9PIcJPP2MaWzYDDhG0yX/EJ4sXZggry3VL4gg==
X-Received: by 2002:a05:6402:23d8:b0:666:d675:e2d9 with SMTP id
 4fb4d7f45d1cf-66b28c711e8mr5369326a12.23.1774859756051; Mon, 30 Mar 2026
 01:35:56 -0700 (PDT)
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
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
In-Reply-To: <20260327220446.353103-5-paul@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Mar 2026 10:35:44 +0200
X-Gm-Features: AQROBzBDqnCdh1lsySXMReag-koNqxFZzXRJut44t6M3sk3oI72QO2jo_kKOcqI
Message-ID: <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000495a5d064e39bd4e"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.10 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3111-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,paul-moore.com:email]
X-Rspamd-Queue-Id: 5A867357432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000495a5d064e39bd4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Stacked filesystems such as overlayfs do not currently provide the
> necessary mechanisms for LSMs to properly enforce access controls on the
> mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> security blob is being added to the backing_file struct and the following
> new LSM hooks are being created:
>
>  security_backing_file_alloc()
>  security_backing_file_free()
>  security_mmap_backing_file()
>
> The first two hooks are to manage the lifecycle of the LSM security blob
> in the backing_file struct, while the third provides a new mmap() access
> control point for the underlying backing file.  It is also expected that
> LSMs will likely want to update their security_file_mprotect() callback
> to address issues with their mprotect() controls, but that does not
> require a change to the security_file_mprotect() LSM hook.
>
> There are a two other small changes to support these new LSM hooks.  We
> pass the user file associated with a backing file down to
> alloc_empty_backing_file() so it can be included in the
> security_backing_file_alloc() hook, and we constify the file struct field
> in the LSM common_audit_data struct to better support LSMs that need to
> pass a const file struct pointer into the common LSM audit code.
>
> Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> and supplying a fixup.
>
> Cc: stable@vger.kernel.org
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  18 ++++--
>  fs/erofs/ishare.c             |  10 +++-
>  fs/file_table.c               |  21 ++++++-
>  fs/fuse/passthrough.c         |   2 +-
>  fs/internal.h                 |   3 +-
>  fs/overlayfs/dir.c            |   2 +-
>  fs/overlayfs/file.c           |   2 +-
>  include/linux/backing-file.h  |   4 +-
>  include/linux/fs.h            |   1 +
>  include/linux/lsm_audit.h     |   2 +-
>  include/linux/lsm_hook_defs.h |   5 ++
>  include/linux/lsm_hooks.h     |   1 +
>  include/linux/security.h      |  22 ++++++++
>  security/lsm.h                |   1 +
>  security/lsm_init.c           |   9 +++
>  security/security.c           | 100 ++++++++++++++++++++++++++++++++++
>  16 files changed, 187 insertions(+), 16 deletions(-)
>

That looks like a nice clean abstraction to me.

...

> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..0bdc26cae138 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -50,6 +50,7 @@ struct backing_file {
>                 struct path user_path;
>                 freeptr_t bf_freeptr;
>         };
> +       void *security;

This needs ifdef SECURITY
and the name should be user_security

>  };
>
>  #define backing_file(f) container_of(f, struct backing_file, file)
> @@ -66,6 +67,11 @@ void backing_file_set_user_path(struct file *f, const =
struct path *path)
>  }
>  EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>
> +void *backing_file_security(const struct file *f)
> +{
> +       return backing_file(f)->security;
> +}

I prefer the name backing_file_user_security()

Terminology here is very confusing but when saying
"backing file" it is more natural that one is referring to the
backing xfs file with overlayfs has opened.

The "backing file" already has an LSM blob f->f_security
which is fair the call it the "backing file's LSM blob"

Therefore, I think we need to make a distinction, as we did
with backing_file_user_path() and refer to this as something along
the lines of the "backing file's user LSM blob".

> +
>  static inline void file_free(struct file *f)
>  {
>         security_file_free(f);
> @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
>                 percpu_counter_dec(&nr_files);
>         put_cred(f->f_cred);
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
> -               path_put(backing_file_user_path(f));
> -               kmem_cache_free(bfilp_cachep, backing_file(f));
> +               struct backing_file *ff =3D backing_file(f);
> +
> +               security_backing_file_free(&ff->security);
> +               path_put(&ff->user_path);
> +               kmem_cache_free(bfilp_cachep, ff);

Not directly related to your patch, but as this is growing, IMO
this would look cleaner with backing_file_free() inline helper
(see attached path).

>         } else {
>                 kmem_cache_free(filp_cachep, f);
>         }
> @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, co=
nst struct cred *cred)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
,
> +                                     const struct file *user_file)
>  {
>         struct backing_file *ff;
>         int error;
> @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, con=
st struct cred *cred)
>         }
>
>         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> +       error =3D security_backing_file_alloc(&ff->security, user_file);
> +       if (unlikely(error)) {
> +               fput(&ff->file);
> +               return ERR_PTR(error);
> +       }
>         return &ff->file;
>  }

There is an API issue here.
in order to call fput() we must ensure that user_security was initialized t=
o
NULL (or allocated).

I don't think that we want security_backing_file_alloc() to provide this
semantic and the current patch does not implement it.

Furthermore, user_path is also not initialized in the error case.

Attached UNTESTED fixup patch to suggest a cleanup with
init_backing_file() helper.

It also changes the variable and helper name to user_security
and plays some trick to avoid many ifdef SECURITY.
Feel free to take whichever bits you like with/without attribution.

If you prefer, attached also a proper prep patch.
compile tested only.

Thanks,
Amir.

--000000000000495a5d064e39bd4e
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-backing_file_user_security.patch"
Content-Disposition: attachment; 
	filename="0001-backing_file_user_security.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mncx4u4t0>
X-Attachment-Id: f_mncx4u4t0

RnJvbSA0ODU4ZjYxMGQ5NjA0NTRhYjRkZTBmMjlmMzU1NzAxNmU4MDg0OGJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDMwIE1hciAyMDI2IDA4OjI2OjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYmFj
a2luZ19maWxlX3VzZXJfc2VjdXJpdHkKCi0tLQogZnMvZmlsZV90YWJsZS5jICAgIHwgNDcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogaW5jbHVkZS9saW51
eC9mcy5oIHwgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmlsZV90YWJsZS5j
CmluZGV4IDBiZGMyNmNhZTEzODkuLjQ2NjZlODhiYTY4N2QgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGVf
dGFibGUuYworKysgYi9mcy9maWxlX3RhYmxlLmMKQEAgLTQzLDE0ICs0MywxOSBAQCBzdGF0aWMg
c3RydWN0IGttZW1fY2FjaGUgKmJmaWxwX2NhY2hlcCBfX3JvX2FmdGVyX2luaXQ7CiAKIHN0YXRp
YyBzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgbnJfZmlsZXMgX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9z
bXA7CiAKLS8qIENvbnRhaW5lciBmb3IgYmFja2luZyBmaWxlIHdpdGggb3B0aW9uYWwgdXNlciBw
YXRoICovCisvKiBDb250YWluZXIgZm9yIGJhY2tpbmcgZmlsZSB3aXRoIG9wdGlvbmFsIHVzZXIg
cGF0aCBhbmQgc2VjdXJpdHkgYmxvYiAqLwogc3RydWN0IGJhY2tpbmdfZmlsZSB7CiAJc3RydWN0
IGZpbGUgZmlsZTsKIAl1bmlvbiB7CiAJCXN0cnVjdCBwYXRoIHVzZXJfcGF0aDsKIAkJZnJlZXB0
cl90IGJmX2ZyZWVwdHI7CisJCXZvaWQgKmR1bW15X3NlY3VyaXR5OwogCX07Ci0Jdm9pZCAqc2Vj
dXJpdHk7CisjaWZkZWYgQ09ORklHX1NFQ1VSSVRZCisJdm9pZCAqdXNlcl9zZWN1cml0eTsKKyNl
bHNlCisjZGVmaW5lIHVzZXJfc2VjdXJpdHkgZHVtbXlfc2VjdXJpdHkKKyNlbmRpZgogfTsKIAog
I2RlZmluZSBiYWNraW5nX2ZpbGUoZikgY29udGFpbmVyX29mKGYsIHN0cnVjdCBiYWNraW5nX2Zp
bGUsIGZpbGUpCkBAIC02Nyw5ICs3MiwxNiBAQCB2b2lkIGJhY2tpbmdfZmlsZV9zZXRfdXNlcl9w
YXRoKHN0cnVjdCBmaWxlICpmLCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCkKIH0KIEVYUE9SVF9T
WU1CT0xfR1BMKGJhY2tpbmdfZmlsZV9zZXRfdXNlcl9wYXRoKTsKIAotdm9pZCAqYmFja2luZ19m
aWxlX3NlY3VyaXR5KGNvbnN0IHN0cnVjdCBmaWxlICpmKQordm9pZCAqYmFja2luZ19maWxlX3Vz
ZXJfc2VjdXJpdHkoc3RydWN0IGZpbGUgKmYpCiB7Ci0JcmV0dXJuIGJhY2tpbmdfZmlsZShmKS0+
c2VjdXJpdHk7CisJcmV0dXJuIGJhY2tpbmdfZmlsZShmKS0+dXNlcl9zZWN1cml0eTsKK30KKwor
c3RhdGljIGlubGluZSB2b2lkIGJhY2tpbmdfZmlsZV9mcmVlKHN0cnVjdCBiYWNraW5nX2ZpbGUg
KmZmKQoreworCXNlY3VyaXR5X2JhY2tpbmdfZmlsZV9mcmVlKCZmZi0+dXNlcl9zZWN1cml0eSk7
CisJcGF0aF9wdXQoJmZmLT51c2VyX3BhdGgpOworCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNo
ZXAsIGZmKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGZpbGVfZnJlZShzdHJ1Y3QgZmlsZSAq
ZikKQEAgLTc5LDExICs5MSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmaWxlX2ZyZWUoc3RydWN0
IGZpbGUgKmYpCiAJCXBlcmNwdV9jb3VudGVyX2RlYygmbnJfZmlsZXMpOwogCXB1dF9jcmVkKGYt
PmZfY3JlZCk7CiAJaWYgKHVubGlrZWx5KGYtPmZfbW9kZSAmIEZNT0RFX0JBQ0tJTkcpKSB7Ci0J
CXN0cnVjdCBiYWNraW5nX2ZpbGUgKmZmID0gYmFja2luZ19maWxlKGYpOwotCi0JCXNlY3VyaXR5
X2JhY2tpbmdfZmlsZV9mcmVlKCZmZi0+c2VjdXJpdHkpOwotCQlwYXRoX3B1dCgmZmYtPnVzZXJf
cGF0aCk7Ci0JCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNoZXAsIGZmKTsKKwkJYmFja2luZ19m
aWxlX2ZyZWUoYmFja2luZ19maWxlKGYpKTsKIAl9IGVsc2UgewogCQlrbWVtX2NhY2hlX2ZyZWUo
ZmlscF9jYWNoZXAsIGYpOwogCX0KQEAgLTI5Miw2ICszMDAsMjMgQEAgc3RydWN0IGZpbGUgKmFs
bG9jX2VtcHR5X2ZpbGVfbm9hY2NvdW50KGludCBmbGFncywgY29uc3Qgc3RydWN0IGNyZWQgKmNy
ZWQpCiAJcmV0dXJuIGY7CiB9CiAKK3N0YXRpYyBpbnQgaW5pdF9iYWNraW5nX2ZpbGUoc3RydWN0
IGJhY2tpbmdfZmlsZSAqZmYsCisJCQkgICAgIGNvbnN0IHN0cnVjdCBmaWxlICp1c2VyX2ZpbGUp
Cit7CisJaW50IGVycm9yOworCisJbWVtc2V0KCZmZi0+dXNlcl9wYXRoLCAwLCBzaXplb2YoZmYt
PnVzZXJfcGF0aCkpOworCWZmLT51c2VyX3NlY3VyaXR5ID0gTlVMTDsKKworCWVycm9yID0gc2Vj
dXJpdHlfYmFja2luZ19maWxlX2FsbG9jKCZmZi0+dXNlcl9zZWN1cml0eSwgdXNlcl9maWxlKTsK
KwlpZiAodW5saWtlbHkoZXJyb3IpKSB7CisJCWZwdXQoJmZmLT5maWxlKTsKKwkJcmV0dXJuIEVS
Ul9QVFIoZXJyb3IpOworCX0KKworCXJldHVybiAwOworfQorCiAvKgogICogVmFyaWFudCBvZiBh
bGxvY19lbXB0eV9maWxlKCkgdGhhdCBhbGxvY2F0ZXMgYSBiYWNraW5nX2ZpbGUgY29udGFpbmVy
CiAgKiBhbmQgZG9lc24ndCBjaGVjayBhbmQgbW9kaWZ5IG5yX2ZpbGVzLgpAQCAtMzE1LDEyICsz
NDAsMTQgQEAgc3RydWN0IGZpbGUgKmFsbG9jX2VtcHR5X2JhY2tpbmdfZmlsZShpbnQgZmxhZ3Ms
IGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkLAogCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CiAJfQog
CisJLy8gVGhlIGZfbW9kZSBmbGFncyBtdXN0IGJlIHNldCBiZWZvcmUgZnB1dCgpCiAJZmYtPmZp
bGUuZl9tb2RlIHw9IEZNT0RFX0JBQ0tJTkcgfCBGTU9ERV9OT0FDQ09VTlQ7Ci0JZXJyb3IgPSBz
ZWN1cml0eV9iYWNraW5nX2ZpbGVfYWxsb2MoJmZmLT5zZWN1cml0eSwgdXNlcl9maWxlKTsKKwll
cnJvciA9IGluaXRfYmFja2luZ19maWxlKGZmLCB1c2VyX2ZpbGUpOwogCWlmICh1bmxpa2VseShl
cnJvcikpIHsKIAkJZnB1dCgmZmYtPmZpbGUpOwogCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CiAJ
fQorCiAJcmV0dXJuICZmZi0+ZmlsZTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGFsbG9jX2VtcHR5
X2JhY2tpbmdfZmlsZSk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRl
L2xpbnV4L2ZzLmgKaW5kZXggOGY1NzAyY2ZiNWUwYi4uNjA0NTBhMDc5MGFkZCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgvZnMuaApAQCAtMjQ3NCw3
ICsyNDc0LDcgQEAgc3RydWN0IGZpbGUgKmRlbnRyeV9vcGVuX25vbm90aWZ5KGNvbnN0IHN0cnVj
dCBwYXRoICpwYXRoLCBpbnQgZmxhZ3MsCiBzdHJ1Y3QgZmlsZSAqZGVudHJ5X2NyZWF0ZShzdHJ1
Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzLCB1bW9kZV90IG1vZGUsCiAJCQkgICBjb25zdCBzdHJ1
Y3QgY3JlZCAqY3JlZCk7CiBjb25zdCBzdHJ1Y3QgcGF0aCAqYmFja2luZ19maWxlX3VzZXJfcGF0
aChjb25zdCBzdHJ1Y3QgZmlsZSAqZik7Ci12b2lkICpiYWNraW5nX2ZpbGVfc2VjdXJpdHkoY29u
c3Qgc3RydWN0IGZpbGUgKmYpOwordm9pZCAqYmFja2luZ19maWxlX3VzZXJfc2VjdXJpdHkoY29u
c3Qgc3RydWN0IGZpbGUgKmYpOwogCiAvKgogICogV2hlbiBtbWFwcGluZyBhIGZpbGUgb24gYSBz
dGFja2FibGUgZmlsZXN5c3RlbSAoZS5nLiwgb3ZlcmxheWZzKSwgdGhlIGZpbGUKLS0gCjIuNTMu
MAoK
--000000000000495a5d064e39bd4e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-prepare-for-adding-user_security-block-to-backing.patch"
Content-Disposition: attachment; 
	filename="0001-fs-prepare-for-adding-user_security-block-to-backing.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mncxnnsn1>
X-Attachment-Id: f_mncxnnsn1

RnJvbSBjYWQxZGYyODBiY2M5MzUyODljNzg3ZjVmNGRlYjRhMjNlYTIwZmNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDMwIE1hciAyMDI2IDEwOjI3OjUxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZnM6
IHByZXBhcmUgZm9yIGFkZGluZyB1c2VyX3NlY3VyaXR5IGJsb2NrIHRvIGJhY2tpbmdfZmlsZQoK
SW4gcHJlcGFyYXRpb24gdG8gYWRkaW5nIHVzZXJfc2VjdXJpdHkgYmxvYiB0byBiYWNraW5nX2Zp
bGUgc3RydWN0LApmYWN0b3Igb3V0IGhlbHBlcnMgaW5pdF9iYWNraW5nX2ZpbGUoKSBhbmQgYmFj
a2luZ19maWxlX2ZyZWUoKS4KClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+Ci0tLQogZnMvZmlsZV90YWJsZS5jIHwgMjIgKysrKysrKysrKysrKysrKysr
KystLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmlsZV90YWJsZS5jCmluZGV4IGFhYTVm
YWFhY2UxZTkuLjllMDJjMWYxNmRiM2MgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGVfdGFibGUuYworKysg
Yi9mcy9maWxlX3RhYmxlLmMKQEAgLTY2LDYgKzY2LDEyIEBAIHZvaWQgYmFja2luZ19maWxlX3Nl
dF91c2VyX3BhdGgoc3RydWN0IGZpbGUgKmYsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoKQogfQog
RVhQT1JUX1NZTUJPTF9HUEwoYmFja2luZ19maWxlX3NldF91c2VyX3BhdGgpOwogCitzdGF0aWMg
aW5saW5lIHZvaWQgYmFja2luZ19maWxlX2ZyZWUoc3RydWN0IGJhY2tpbmdfZmlsZSAqZmYpCit7
CisJcGF0aF9wdXQoJmZmLT51c2VyX3BhdGgpOworCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNo
ZXAsIGZmKTsKK30KKwogc3RhdGljIGlubGluZSB2b2lkIGZpbGVfZnJlZShzdHJ1Y3QgZmlsZSAq
ZikKIHsKIAlzZWN1cml0eV9maWxlX2ZyZWUoZik7CkBAIC03Myw4ICs3OSw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBmaWxlX2ZyZWUoc3RydWN0IGZpbGUgKmYpCiAJCXBlcmNwdV9jb3VudGVyX2Rl
YygmbnJfZmlsZXMpOwogCXB1dF9jcmVkKGYtPmZfY3JlZCk7CiAJaWYgKHVubGlrZWx5KGYtPmZf
bW9kZSAmIEZNT0RFX0JBQ0tJTkcpKSB7Ci0JCXBhdGhfcHV0KGJhY2tpbmdfZmlsZV91c2VyX3Bh
dGgoZikpOwotCQlrbWVtX2NhY2hlX2ZyZWUoYmZpbHBfY2FjaGVwLCBiYWNraW5nX2ZpbGUoZikp
OworCQliYWNraW5nX2ZpbGVfZnJlZShiYWNraW5nX2ZpbGUoZikpOwogCX0gZWxzZSB7CiAJCWtt
ZW1fY2FjaGVfZnJlZShmaWxwX2NhY2hlcCwgZik7CiAJfQpAQCAtMjgzLDYgKzI4OCwxMiBAQCBz
dHJ1Y3QgZmlsZSAqYWxsb2NfZW1wdHlfZmlsZV9ub2FjY291bnQoaW50IGZsYWdzLCBjb25zdCBz
dHJ1Y3QgY3JlZCAqY3JlZCkKIAlyZXR1cm4gZjsKIH0KIAorc3RhdGljIGludCBpbml0X2JhY2tp
bmdfZmlsZShzdHJ1Y3QgYmFja2luZ19maWxlICpmZikKK3sKKwltZW1zZXQoJmZmLT51c2VyX3Bh
dGgsIDAsIHNpemVvZihmZi0+dXNlcl9wYXRoKSk7CisJcmV0dXJuIDA7Cit9CisKIC8qCiAgKiBW
YXJpYW50IG9mIGFsbG9jX2VtcHR5X2ZpbGUoKSB0aGF0IGFsbG9jYXRlcyBhIGJhY2tpbmdfZmls
ZSBjb250YWluZXIKICAqIGFuZCBkb2Vzbid0IGNoZWNrIGFuZCBtb2RpZnkgbnJfZmlsZXMuCkBA
IC0zMDUsNyArMzE2LDE0IEBAIHN0cnVjdCBmaWxlICphbGxvY19lbXB0eV9iYWNraW5nX2ZpbGUo
aW50IGZsYWdzLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkKIAkJcmV0dXJuIEVSUl9QVFIoZXJy
b3IpOwogCX0KIAorCS8vIFRoZSBmX21vZGUgZmxhZ3MgbXVzdCBiZSBzZXQgYmVmb3JlIGZwdXQo
KQogCWZmLT5maWxlLmZfbW9kZSB8PSBGTU9ERV9CQUNLSU5HIHwgRk1PREVfTk9BQ0NPVU5UOwor
CWVycm9yID0gaW5pdF9iYWNraW5nX2ZpbGUoZmYpOworCWlmICh1bmxpa2VseShlcnJvcikpIHsK
KwkJZnB1dCgmZmYtPmZpbGUpOworCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CisJfQorCiAJcmV0
dXJuICZmZi0+ZmlsZTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGFsbG9jX2VtcHR5X2JhY2tpbmdf
ZmlsZSk7Ci0tIAoyLjUzLjAKCg==
--000000000000495a5d064e39bd4e--

