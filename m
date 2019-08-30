Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4349FA3624
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 14:00:22 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KdMf0jMGzDqxV
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 22:00:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567166414;
	bh=UsxPAiaYCwcEuc83peQCNimBn6J/zneOqids0hh+qwA=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ads2fpxG8LYvOoRLpYN6DAEcqzZTG+owlc32b7RVr39qN39F6htw0yDYuARVQGeh/
	 kqPLvuHD5Jb6E6bSXYFGG0qpBqIAVX6OL9PDD65my3JHZJe3Hq2vzrWEyk9/q21g8E
	 l0vEskqJPQLmaQiXB+FVvcLun5gVr7bd1Egp6lwdZ6p2rlvN6mVpLL1cZAdEK65U7+
	 4XqcW5RACjsf0U9BBNbitW15zpQup/Q8kIX6Qe2QTsqWr0e0R/Cpj+dYyeWrxOblgX
	 OD0nIZ76Q3f3B5sAy5PSSYVXj6hiWgTwpos2s4BDcG/hTzeNO2czlFofrC1xIiHDqD
	 X1uFmG84z/L9A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.201; helo=sonic303-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="biPqc2PZ"; 
 dkim-atps=neutral
Received: from sonic303-20.consmr.mail.ir2.yahoo.com
 (sonic303-20.consmr.mail.ir2.yahoo.com [77.238.178.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KdMR5ZD6zDqvK
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2019 22:00:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567166396; bh=WNQcku/ghJ+02xOFF6/bqpQqBFtbzhnUrUZfG3N4Odg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=biPqc2PZaeUn35iIFtuMZ9gQcit7Vjarf9e/WYwir5F8H1QoQEcjkdRm9773j7iQn+1cPrM57gV68wfOhvVTj+hpJlzc6anuR1Dbq529XnOte8CQLoqjk2gakNpoOVrzMvTcJNIWmN+cERAggHvBQmEDrBAu/Uf0U2uK8cObjf3D2TL9B2cpoa3YSAblYuDKaUuNRogqgBY2aL6tHJbqUv1UzSs/PV2vBojRbwpkY2pFtOC9VYHWHWfwlh71PeyGz/DPUVdqQKNgBISMt5FsCg3WiTaU4e+2B5849YYyE8hgc3m35D/Fv2/9vHqH0UCyiZrlnBAyhulOZ077Biojcg==
X-YMail-OSG: LkknR7YVM1nLb90_eSTDuhJtSFPvWDP2rElYtNbbjaNA.iZsNzrrvrfviK.qIjd
 IXus2o7fdFy6guCWcEE1IcmtzHO0sZbnBf7YkuNpoTiFCIpo.tNy7fj_OtTGtImv7z_dJ4pjY9z4
 W0mJAmtvroVvwMayYQnelkXq5BUC_DgCITBo.8A0LdP01631DXZmtbDsZffAgmJ3QCQYMIL3iNo4
 7eVmJbyav6A_9XjIXnEE3bxIgnQi62jL4ApxnQKyknlhHOlRQjcAupHVJvMAeyqTmzFirrzMwstk
 3RQRJmzExRWWkAo5KxLzsVihNahDDdx0WmD_nxpE5ZWPREMdhrfCVMQivesX625BIVMyIGWY7ajy
 IP8hZXqh_skzrx_voSMJ8GuswsehWaQu47RDvG1MfoPYy8IIkM1zdlm0i8nb27qtSYVa3xnxOIAN
 pqnRhCJCN2SNgDA_IkK01WOohiwW_2qkPG9UMAGvWCYGX89j7ycfKx7C5qQjmubla6739vIZS4vj
 Q5WKt.3zdqNE8yzMUQOiXJl7fhSe3jdVgBAkF_0hPB9DPUfDKjUs2w3yS8FuXhrkrD4cGhxJUh9e
 a0WAS334xn7ZX8oPLuXiI5b998pUuVTUo9UGvXvGvS1JPDp9Dt2Ayz.5EkkZzM5Kddug813J3o1U
 f8QA8M5RAT7eWeJQpphKkIPS5JPY32B2jf40HmTpjo0rId9P4Ansa3uj06t6nwoU7NaY7jRD9nuZ
 937KKs3dRTVWWlk9p2LOhM1EgvXs7onekJYZ7aNFgtIgJHCOhEJfPgS7.RIuJojDUbYUv1ymhYQn
 CBXad.giLCj6eUOW6W.LbAdGz16oV7LlbKvHOraBv4BBhEvn3q4qExZfHVean2IxytEWHL_WBGmY
 _4wTd42W4DAjjUM5maZzDNVGlNpKqqiWelN3felx6eseB0e_6oxuzhwx1o2LH7ztSXW3qdrkCUxg
 W8P.CiVPaQXGPGLCHN_hSkMDsAzpW8uiKLtE1HolBwKsbLIVNNetgVwWwVOcIerv2ai8q40aPpG0
 iHKzCxoqtuUyZnQA3t526NFuo_ESLfCN9NDk3dbyKdRWoax6CamsNBeE7Dh6aurV7zDAxwnp.9h.
 VeOUNJlNeP8mwrk8QPjlDtKLLAEK_ZsOEfJjbqela8Qzrpmwata_ym.s3cNRHE0OMICdBT3xGEMG
 qbvGhXswzZKllomaKHS9pbCWpfdohlXI2zZ_nN_217Cpr09wzCAO1BSjKvBAFmJGr98IdWokPJ9F
 0ghXJHYTyS3lm8wrY5x3SUzS0ca_niuI-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ir2.yahoo.com with HTTP; Fri, 30 Aug 2019 11:59:56 +0000
Received: by smtp432.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 08026dd6bbce525e72ed2e9b63384b86; 
 Fri, 30 Aug 2019 11:59:55 +0000 (UTC)
Date: Fri, 30 Aug 2019 19:59:48 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs: using switch-case while checking the inode type.
Message-ID: <20190830115947.GA10981@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190830095615.10995-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830095615.10995-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 gregkh@linuxfoundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

The subject line could be better as '[PATCH v2] xxxxxx'...

On Fri, Aug 30, 2019 at 03:26:15PM +0530, Pratik Shinde wrote:
> while filling the linux inode, using switch-case statement to check
> the type of inode.
> switch-case statement looks more clean here.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

I have no problem of this patch, and I will do a test and reply
you "Reviewed-by:" in hours (I'm doing another patchset to resolve
what Christoph suggested again)...

Thanks,
Gao Xiang

> ---
>  fs/erofs/inode.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 80f4fe9..6336cc1 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -190,22 +190,28 @@ static int fill_inode(struct inode *inode, int isdir)
>  	err = read_inode(inode, data + ofs);
>  	if (!err) {
>  		/* setup the new inode */
> -		if (S_ISREG(inode->i_mode)) {
> +		switch (inode->i_mode & S_IFMT) {
> +		case S_IFREG:
>  			inode->i_op = &erofs_generic_iops;
>  			inode->i_fop = &generic_ro_fops;
> -		} else if (S_ISDIR(inode->i_mode)) {
> +			break;
> +		case S_IFDIR:
>  			inode->i_op = &erofs_dir_iops;
>  			inode->i_fop = &erofs_dir_fops;
> -		} else if (S_ISLNK(inode->i_mode)) {
> +			break;
> +		case S_IFLNK:
>  			/* by default, page_get_link is used for symlink */
>  			inode->i_op = &erofs_symlink_iops;
>  			inode_nohighmem(inode);
> -		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
> -			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
> +			break;
> +		case S_IFCHR:
> +		case S_IFBLK:
> +		case S_IFIFO:
> +		case S_IFSOCK:
>  			inode->i_op = &erofs_generic_iops;
>  			init_special_inode(inode, inode->i_mode, inode->i_rdev);
>  			goto out_unlock;
> -		} else {
> +		default:
>  			err = -EFSCORRUPTED;
>  			goto out_unlock;
>  		}
> -- 
> 2.9.3
> 
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
