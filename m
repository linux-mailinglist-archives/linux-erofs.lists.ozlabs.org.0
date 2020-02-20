Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D883165FDD
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 15:41:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Ncjv5ZCkzDqXZ
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Feb 2020 01:41:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=nvidia.com (client-ip=216.228.121.64;
 helo=hqnvemgate25.nvidia.com; envelope-from=ziy@nvidia.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.a=rsa-sha256
 header.s=n1 header.b=FDT0nYs8; dkim-atps=neutral
X-Greylist: delayed 311 seconds by postgrey-1.36 at bilbo;
 Fri, 21 Feb 2020 01:41:40 AEDT
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Ncjc1k9MzDqR2
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Feb 2020 01:41:39 +1100 (AEDT)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e4e99460000>; Thu, 20 Feb 2020 06:35:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 20 Feb 2020 06:36:23 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 06:36:23 -0800
Received: from [10.2.165.18] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Feb
 2020 14:36:22 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 04/24] mm: Move readahead nr_pages check into read_pages
Date: Thu, 20 Feb 2020 09:36:19 -0500
X-Mailer: MailMate (1.13.1r5678)
Message-ID: <DD2E8059-DA56-468F-9185-6C0082266067@nvidia.com>
In-Reply-To: <20200219210103.32400-5-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-5-willy@infradead.org>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
 boundary="=_MailMate_4CC2553B-18F9-4690-BE6D-05CCB84498AD_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1582209350; bh=SnJgwePGNz1KwP9XyCGDsyTNIXJm80RakRuVGnRNh2k=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
 In-Reply-To:References:MIME-Version:X-Originating-IP:
 X-ClientProxiedBy:Content-Type;
 b=FDT0nYs8cnBGBsD6LKu9r++ThtzZy580JjSbKP96scj+mumshmfRQ2FjF9WE2bWgG
 ZZd9Fkvay66NTmXX6GgKLwclVAHoCvF5uyeVrtd+8sdUsLUkbjdjbG8TvhaCarpiIx
 JlVLlpbLLJJjFXv6LO/jrVsBsRX6mKL01/zN9gcaxnklD5XBnv+o9jI5hIeKrWeIFv
 QY0c6t8P3/c4rXn9W5moLgbjwvi63enWEhSpHRtmkPjazAasGSOg2mg9+nm8O5ImLC
 OSi8yuXPNFPHWC7TOSxXEFi3U+IFL3YDIgGIX1mnREWvHTr/ZC/ZmoovE5FHlDuD+z
 N1sfrm/KY8NyA==
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--=_MailMate_4CC2553B-18F9-4690-BE6D-05CCB84498AD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Feb 2020, at 16:00, Matthew Wilcox wrote:

> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Simplify the callers by moving the check for nr_pages and the BUG_ON
> into read_pages().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/readahead.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 61b15b6b9e72..9fcd4e32b62d 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -119,6 +119,9 @@ static void read_pages(struct address_space *mappin=
g, struct file *filp,
>  	struct blk_plug plug;
>  	unsigned page_idx;
>
> +	if (!nr_pages)
> +		return;
> +
>  	blk_start_plug(&plug);
>
>  	if (mapping->a_ops->readpages) {
> @@ -138,6 +141,8 @@ static void read_pages(struct address_space *mappin=
g, struct file *filp,
>
>  out:
>  	blk_finish_plug(&plug);
> +
> +	BUG_ON(!list_empty(pages));
>  }
>
>  /*
> @@ -180,8 +185,7 @@ void __do_page_cache_readahead(struct address_space=
 *mapping,
>  			 * contiguous pages before continuing with the next
>  			 * batch.
>  			 */
> -			if (nr_pages)
> -				read_pages(mapping, filp, &page_pool, nr_pages,
> +			read_pages(mapping, filp, &page_pool, nr_pages,
>  						gfp_mask);
>  			nr_pages =3D 0;
>  			continue;
> @@ -202,9 +206,7 @@ void __do_page_cache_readahead(struct address_space=
 *mapping,
>  	 * uptodate then the caller will launch readpage again, and
>  	 * will then handle the error.
>  	 */
> -	if (nr_pages)
> -		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
> -	BUG_ON(!list_empty(&page_pool));
> +	read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
>  }
>
>  /*
> -- =

> 2.25.0

Looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan Zi

--=_MailMate_4CC2553B-18F9-4690-BE6D-05CCB84498AD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl5OmWMPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKYawQAJnDCzvIOBkSaYYorEht2VZXHuWxGxkTwhkM
TvpQUkB3Cff2onVNqU2DPF0usuD2Nr1qda6WHnPwGeTbxCokAwTsFkkn8JhJkqVf
2/xydKKHCGEdaL5n8d86v6J0kQx6Do1jBCqLOIx0rGVuCL0apnya4jKfrNO4OCAb
T4pwf6/Qm2E2bBj3ISvybn/TYKq9WPpAu/ryMLNPidYqMqJiX4iqJ/RnBZ7srPcH
TutPMCYvOJ4oUtbTzYq6AHiFfANTGKnBBeiH3v9QdJAla6/7FeiL9G6fEwMK0C3g
FnzbqkYnPf+nR7a6Yg5ZejT33u9g7CP18xykij7jYUxPe7G1P2gVFflDIzkDie0+
LgYPICjmeYOKQxi2nrax2NpS+PqKq2mcGoZANosRwWvdlS0N/pUfOVZiCk2E8q7V
UIi0c16u5lhuGpTCd2Y0rDxpItZ/eh912iqaxkjhKqlgxNdO1n78/2tiAXf/JqD9
xt1LEjKMkDUxiqvvCvJNXONKWSyATDPWlwXZSdjMi0jjsdusO+74WDheJm9Y0ylN
o8+lS74JyYFdmRRMlyfPDeNDdIjLJf5FL1Ke+8vR85rwt0yBRY7CGj37O6LlCHMM
eo4carZ4q5rC3EnAG0+Lf3uYaQXCbr0R1vvZkqnLJZfJuhFdMjI0l7fb/02PBG3L
f+4j17Gl
=Jsz+
-----END PGP SIGNATURE-----

--=_MailMate_4CC2553B-18F9-4690-BE6D-05CCB84498AD_=--
