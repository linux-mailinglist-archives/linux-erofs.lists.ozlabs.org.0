Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E624545AE67
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Nov 2021 22:22:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzHCp60QDz2yZC
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 08:22:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel-com.20210112.gappssmtp.com header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=b/hUI3hQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20210112.gappssmtp.com
 header.i=@intel-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=b/hUI3hQ; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzHCl3J59z2xYK
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 08:22:26 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id h63so210416pgc.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Nov 2021 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
 b=b/hUI3hQLxDR2Xk9r7lQxFzBrg/2/5tGZW+JSVwNYrq8dmNWS3P9ynBIU8RZmfFHUI
 Xgm0552sZFP2+qPF3soghwDd7XxX6FGNBFe395T6bvF+N1dr29Lop15wmWK8lt8m87yV
 9vAVuWAMC6kkIO1VclhYl3oilFONamQuNci0i1jGGdKo0v4NlKYSPdpcWln2MSBf1py8
 eotcm4rw3pNPGNJSmy6HW2en9pvx0GUA8KH3ho166JTJ5FG5ph7IQpvk6v1nkInbqZW5
 YGsf77VgzBkZO6x5IA8KcT5QTl5SnWc54c+GTeaTywwpW3otwTRaZbbIpfY5ylF9vOkP
 iFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bLSToY/Rn4QaplrUteOdrUS7Uug3uZWr/TlOz9Y1nF0=;
 b=03Uvu7sK7BX+WDCgVgoTd5poPDBwqtwclsThxNyLm5TI8sooFUFVbz8U4EHg25kmhm
 H3NkANiUp2/WrAhTKEGmCNhp8Cp8xKuuq6kpW6uGPu5X6OJvp98nKzmy1Ks+PJD91B1b
 KoiyZShHutFtV9RQ0LHrFIPdnfKSyN5KFKpB1Xg0huMXljukrKkMtkl8w3NfnhFCygmS
 WvCRcZjQQheZq63NMZXT8g6CZCtDSGbW/q0qWbYy0cApbFhjftFHEg5WKm418c+5EOh1
 QsB27Lr3hDCmn/xNwpRUmD+/9fcPTWVBU5w0xESS3xMvn0W14VZEYZPpmFS/G0sRn96B
 OApg==
X-Gm-Message-State: AOAM5318z/JQXwnyVwHiJ1czUnvtCQwmnv9bVJdUcr1MNP7RLNxYhDNg
 4Sb0MjTuf66gljbRUDbNfI9EipkF+1jRAHXbJlyWaw==
X-Google-Smtp-Source: ABdhPJynvi8g71RwjaWWgFjo9LaoTAJgYi1+7huNhjnlJVCNZL4JsPbOJLOogDISiszVaR5xm5B316tq/pqSlm2ohsA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr476612pfu.61.1637702544283; Tue, 23 Nov
 2021 13:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-18-hch@lst.de>
In-Reply-To: <20211109083309.584081-18-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Nov 2021 13:22:13 -0800
Message-ID: <CAPcyv4imPgBEbhDCQpDwCQUTxOQy=RT9ZkAueBQdPKXOLNmrAQ@mail.gmail.com>
Subject: Re: [PATCH 17/29] fsdax: factor out a dax_memzero helper
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Factor out a helper for the "manual" zeroing of a DAX range to clean
> up dax_iomap_zero a lot.
>

Small / optional fixup below:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/dax.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index d7a923d152240..dc9ebeff850ab 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>
> +static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
> +               unsigned int offset, size_t size)
> +{
> +       void *kaddr;
> +       long rc;
> +
> +       rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> +       if (rc >= 0) {

Technically this should be "> 0" because dax_direct_access() returns
nr_available_pages @pgoff, but this isn't broken because
dax_direct_access() converts the "zero pages available" case into
-ERANGE.

> +               memset(kaddr + offset, 0, size);
> +               dax_flush(dax_dev, kaddr + offset, size);
> +       }
> +       return rc;
> +}
> +
>  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  {
>         pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
>         long rc, id;
> -       void *kaddr;
> -       bool page_aligned = false;
>         unsigned offset = offset_in_page(pos);
>         unsigned size = min_t(u64, PAGE_SIZE - offset, length);
>
> -       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
> -               page_aligned = true;
> -
>         id = dax_read_lock();
> -
> -       if (page_aligned)
> +       if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
>                 rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
>         else
> -               rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
> -       if (rc < 0) {
> -               dax_read_unlock(id);
> -               return rc;
> -       }
> -
> -       if (!page_aligned) {
> -               memset(kaddr + offset, 0, size);
> -               dax_flush(iomap->dax_dev, kaddr + offset, size);
> -       }
> +               rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
>         dax_read_unlock(id);
> +
> +       if (rc < 0)
> +               return rc;
>         return size;
>  }
>
> --
> 2.30.2
>
