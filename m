Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C11FBD01
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 01:26:59 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47D2Nd0Z6MzF4hx
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 11:26:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1573691217;
	bh=wsjjMjFD7vfu2ke2wKNA6/402+U1BPmnstgn60Oal1c=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ioUrydyqhh/D/MJLbjXh+j49LrnKODJHeOqBEk9SHrJKLXhVknDnnlkglajiA7Pcj
	 RQkjBfdfjr5xLkUM2v1U8Px3NtZ3hxZw3iykBTB3KqarFJ+blqY9TP8KjMCoPO87+6
	 L8bqzSD3DosMASk02/ijq5fdmSNKdjdynHy/ICU8mvwaxitBDUt8BBr9RILEq2ACRT
	 pUmQEn8tTE2kW/NkYflqQqJ/enYWPSyPvTjQtQtkor2f5JnHMYaC7i5BWqIV3h9Hs9
	 KP+CV3LMRmIObJ//CMGNtLyaBabd/Kbp8ckDi+REmRKAft3aU7uhmfljD01YpNTwe6
	 z//YFLDtIoWTQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.58; helo=sonic315-34.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="cqgbcu6P"; 
 dkim-atps=neutral
Received: from sonic315-34.consmr.mail.gq1.yahoo.com
 (sonic315-34.consmr.mail.gq1.yahoo.com [98.137.65.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D2NN5Xb8zF3FB
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 11:26:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1573691199; bh=IIUjZ9Zxsxq8FdCl0YHRseFGE1am/4BxSTpnmi6EecM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=cqgbcu6PNYzwlFOPkTXaaoL/yd9Q39FnPAPHWAq+Km60Qgaqe7Ht+wgLeFUMhx8lppnwtj2YMYfqbgAakYGIc4c2VZLczVmv/ZMLy5n6H1BxrgAq8eeF7khGjc2undxTlSntDrYuZatvgo55i38xnn+nVEHTrlMqpS2m8IqUi+LTpGMPkRTyxaxxN+PyQb3fSE+IzvVlUpAF/Zm0mB+Gcbwblr+DB8kjeTUl9Ww7jRH/ymochrQpZEVFv0/dnNniTrVo9igph2I2erMhYVKwT5MIYxUPQLqeGFfua9Qnodr67IIygfxUgZmGjcT8egWXCT6sdMnsyvr6v/wt9jhLlw==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 14 Nov 2019 00:26:39 +0000
Received: by smtp407.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0b7c1199c59a0e5ce794f8cb58b1a4a0; 
 Thu, 14 Nov 2019 00:24:36 +0000 (UTC)
Date: Thu, 14 Nov 2019 08:24:31 +0800
To: Li Guifu <blucerlee@gmail.com>
Subject: Re: [PATCH v2] erofs-utils: complete missing memory handling
Message-ID: <20191114002428.GA2809@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191112112650.143498-1-gaoxiang25@huawei.com>
 <20191113170335.17621-1-blucerlee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113170335.17621-1-blucerlee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Guifu,

On Thu, Nov 14, 2019 at 01:03:35AM +0800, Li Guifu wrote:
> From: Li Guifu <bluce.liguifu@huawei.com>
> 
> memory allocation failure should be handled
> properly in principle.
> 
> Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
> [ Gao Xiang: due to Huawei outgoing email limitation,
>   I have to help Guifu send out his patches at work. ]
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Li Guifu <blucerlee@gmail.com>
> ---

As a common practice, It's perferred to leave some useful
comments at this about what you modified compared wtih
the last version.

>  lib/inode.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/inode.c b/lib/inode.c
> index 86c465e..b6c2b13 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -264,6 +264,8 @@ int erofs_write_dir_file(struct erofs_inode *dir)
>  	if (used) {
>  		/* fill tail-end dir block */
>  		dir->idata = malloc(used);
> +		if (!dir->idata)
> +			return -ENOMEM;
>  		DBG_BUGON(used != dir->idata_size);
>  		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
>  	}
> @@ -286,6 +288,8 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
>  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
>  	if (inode->idata_size) {
>  		inode->idata = malloc(inode->idata_size);
> +		if (!inode->idata)
> +			return -ENOMEM;
>  		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
>  		       inode->idata_size);
>  	}
> @@ -347,9 +351,14 @@ int erofs_write_file(struct erofs_inode *inode)
>  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
>  	if (inode->idata_size) {
>  		inode->idata = malloc(inode->idata_size);
> -
> +		if (!inode->idata) {
> +			errno = ENOMEM;
> +			goto fail;
> +		}
>  		ret = read(fd, inode->idata, inode->idata_size);
>  		if (ret < inode->idata_size) {
> +			free(inode->idata);
> +			inode->idata = NULL;

Anyway, it seems the diffstat is this line.
I think it' better than v1 so let's use this version.

Thanks,
Gao Xiang

