Return-Path: <linux-erofs+bounces-2816-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEI8LvDYuWlHOgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2816-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 23:42:56 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB65F2B3279
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 23:42:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb6Rd4HJ6z2ygK;
	Wed, 18 Mar 2026 09:42:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773787373;
	cv=pass; b=Kq1UFS5Kh6ECBJj+GxM/G/MbIWmYdKNSj0logfrA1+u/O5rEIfqh7A5XsWKzCh52jIQxLrTPuSL4nRtn/hIeoSXu+6BXknLZyCry5l4OgpeIBnSU8SOZ5tHZ8uPknx0B+gfFQ7NjXWDHtmGBLQoen3YSCQlSHA5ALzXeDCs1Ld6a50vf5ZYjNyDrbYYv68ZPU6BwBfHtJUNPuHuu4imSvCo7+MAw0HPR0n6e+r8j6su0s0weVdNznpVRnjbRCiy0AiQ0RYjuH6/SSw5dMm04caPIeuWs3L+QkQErRBtljvya8Q282ZCjep9lGAT+CyFUUYrTa7fJsGs5gZo9eNIeWA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773787373; c=relaxed/relaxed;
	bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUQmNryUCnXPSnlDJk/rZaFotwWPDscvCOzk8m4jIYyvqKX0zKncBCVizG3c4icx68fTnOGRyFzBezvNFHVF6527C8KaMZYtznYpYfiSWW8ny2E/HlLMIUbsXArIkYn31ns4er7t7G0PoYGvUeYYPovxdUtHbLw4kLDIpeBghAanl3S3TQsEHhB2Yg8fFFtPbyE+w3TH6D4/c08G0I3rdG0LzNVD3fJtIgO2yz3O5La04ff5eApxv0d4uSXjbtE+Y08qlMazbSRjn4Y/K5/piAZds4gPNTl1DYJcs0CcWM7byHte9ma3WyC98IuRidXUrSyto+ilXYbdca9eQcGSWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=QYZDF4RB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=QYZDF4RB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb6Rc2c6Tz2ygG
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 09:42:51 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so2280214b3a.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787369; cv=none;
        d=google.com; s=arc-20240605;
        b=VMjbWUsivvhak5tFLFlIHXlgF5coofpzKXAQU3dPUAY3H+SA7IFZCmKXDGSca6YDmD
         065JzU6uXP+531UwudV1ibwgO1DDGEB2bAcDwgeWx7xpJAlTJGr9qdyZHCw/oZ/VdQxu
         AfP5wnCajVJy6ihAPY9htVFTWlaoGJSsm+sPfuzbsBnM6cnl2ZY2dvLbWPQo5ifX1Ryp
         nTm6LwIPI5Nd3ZWBYBgOLJdKBPt3dYw6WogPuKengumBRpT0trs8gskvgBIIYkcSdGTQ
         ZAcnR+WY0IMG0zZQdAWdZP5JWuQDHKvjbSnnPTzpAM5xrF8Tny6sK12RGH5fv6o397oC
         tOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        fh=y1mz3lUfYcGr/eKuJCJiVIe9IbUMAuHBWURd3tnGV7w=;
        b=EYI4Wx6XOorbqgDsrF/W/Yqmb09l300JyzWgtPyFFrbu+WCIcB3rDT0gRvqFTmxGua
         Y1MXt0foXTs5EuD1jcc7K8GZjvRPhWPb1B6Tk3hX1QieidT6j8wGjdIJ2rXEOh5RdvsD
         HLPL2RhZQ/Xj6PrFqGXj3PSWp04R1UMBNDeC1aR4Y2QvJ+aAtwGuGQSQK0VVQn09d3+b
         rOAJ7rrpKcUNxg5zvYSlJ1n1XoEHCvsEOtWXl9M4JM2QBez4xJW4GxqM2sPnr2Eug5gb
         2DyZW0Ki42p0S7aLbgNQPjSkbSiek7u/mLEQkeWbad+LJDxidBdwOQx50tI89uSHK3Oc
         9aFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773787369; x=1774392169; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=QYZDF4RBGcGYoKItlf+iaL3EAuQUl/G9mXDqiVgikHTIEYqp5wEoBDWUBcALSmASdW
         8zz0Bwl5zKABY1z2xgvVkOrt3oL0BhRDTo+SS7nf62MT967nNSkXatJkgw8TfbKi6DRW
         hzjAMRtxMjvwK4uepLxKs43A4plfX3Fup8xFgUpBxm47IyxvIE+bzeyFTspHHD9iUqjm
         hEV8yaxBpL8bSDkz/QvOlgo81hPNmwTKXm00ZXYW2Uba6GOJE+jR043liKwR13OF9avF
         w5bw0vpCQ9B2SpFDQ4M1hkFeM6U8I0J4O6Mg+vxRaXXbjRZHwkFUok0ahIjeRXAxoNo8
         gVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787369; x=1774392169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8weZ6sz5Sw0SJMaIbsh0p66JDKF/4Vt78zNnjgP+G0=;
        b=d7AqMasprmaRkJdjS7nSH0UImdiwVdrNDS9GDRhk33g3R/r6sBs50g5reU+danfWS8
         25k2yw+49Qoc6pYZR0MvQbbr5jcl4J0yXplj0X3B4Hj4rTH2UeGr/dwsFsHEDjYDN8/0
         bRnmxGfYlpqppp4LRIkFZM4gb9njXwYuUEH2AItfGSPLr+mExQG3vuWHFrGeBi6Rybk1
         2sSJvmYX8HU1d2R9yUCNvwxhDlc9TfudLwrfT1udlKDISMNzHx8ADatJtpKQQLtCaKqN
         tii4QAAm7+E+mr+8NHVhsS/vT+QuTuzrFAbWMRQpvbdPD28gC6dD6G8kSlfiB13ewBW8
         n/PA==
X-Forwarded-Encrypted: i=1; AJvYcCUObg1bKy+mwui9FygCZtStcYaachWhv/Abxt/qW04oIX3aVuyCuS+kzlcejwW/gmCYTBfKsdOQxiFlhg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwtyDawQGtkMZxDHRu83A2iuvvjW5tXjqsqj4j7gEUE2CSVW1PJ
	IuOu8jQOufCHWnYFx7LsaW499yIQToJNq1E0AXABBPNqyA1tIudCD1PcSTqBGIFxzpnQkL/6UYu
	qpazRL9kPL8pHI2w+s49cfqgGeVDfs7z+G+f94z+b
X-Gm-Gg: ATEYQzyZQFjUG/xlcKUqY9XuF9rO+sOMBnvQnLlosVSeLFGHd/0PUjMDhChJ6YmOGMt
	H18310j7SlDrSG5fa1B7Bdoe2iV078Oas0cbmi2D5vi4wAfDEzL+fsoDMROtV1oKxtW89x2MjrG
	bG2KzwfxGPvqM0t7dkaLxWLVo7mC8UL+R5cxAcwLub76FkpE84OAadljDfPiNdNcNdWb3ZrCE5i
	EQugUyJVMSfdXMiq1RSp6/21J5mj8HzXc7byn1c1Iw3IrEtL92rBgOuPYjHoKccEuZyHBsPL/Je
	Sd7dpPhe6Rx95iHpTQ==
X-Received: by 2002:a05:6a00:1816:b0:827:2ec9:e1bc with SMTP id
 d2e1a72fcca58-82a6af3b680mr1004833b3a.61.1773787368885; Tue, 17 Mar 2026
 15:42:48 -0700 (PDT)
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
References: <20260316213606.374109-5-paul@paul-moore.com> <20260316213606.374109-7-paul@paul-moore.com>
In-Reply-To: <20260316213606.374109-7-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Mar 2026 18:42:37 -0400
X-Gm-Features: AaiRm51ktGDW1-usZMxMHsT1xbcaRYx3q6Ml_vERE0ki9AcWlEliFtDWBIy0vmI
Message-ID: <CAHC9VhTiB73F9fB1o3K4NfJ-Fa50MsVA_=79kn6X34L62J_TwA@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: add the security_mmap_backing_file() hook
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2816-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DB65F2B3279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Add the security_mmap_backing_file() hook to allow LSMs to properly
> enforce access controls on mmap() operations on stacked filesystems
> such as overlayfs.
>
> The existing security_mmap_file() hook exists as an access control point
> for mmap() but on stacked filesystems it only provides a way to enforce
> access controls on the user visible file.  In order to enforce access
> controls on the underlying backing file, the new
> security_mmap_backing_file() hook is needed.
>
> In addition the LSM hook additions, this patch also constifies the file
> struct field in the LSM common_audit_data struct to better support LSMs
> that will likely need to pass a const file struct pointer from the new
> backing_file_user_path_file() API into the common LSM audit code.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  8 +++++++-
>  fs/erofs/ishare.c             |  6 ++++++
>  include/linux/lsm_audit.h     |  2 +-
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 25 +++++++++++++++++++++++++
>  6 files changed, 51 insertions(+), 2 deletions(-)

...

> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> index 17a4941d4518..d66c3a935d83 100644
> --- a/fs/erofs/ishare.c
> +++ b/fs/erofs/ishare.c
> @@ -150,8 +150,14 @@ static ssize_t erofs_ishare_file_read_iter(struct ki=
ocb *iocb,
>  static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *v=
ma)
>  {
>         struct file *realfile =3D file->private_data;
> +       int err;
>
>         vma_set_file(vma, realfile);
> +
> +       err =3D security_mmap_backing_file(vma, realfile, file);
> +       if (err)
> +               return err;
> +
>         return generic_file_readonly_mmap(file, vma);
>  }

The kernel test robot helpfully pointed out that this patch was
missing a security.h include for the newly added LSM hook.  The fixup
below has been applied to the patch in lsm/stable-7.0.

diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index d66c3a935d83..f80925b66599 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -4,6 +4,7 @@
 */
#include <linux/xxhash.h>
#include <linux/mount.h>
+#include <linux/security.h>
#include "internal.h"
#include "xattr.h"

--=20
paul-moore.com

