Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E052052366
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 08:16:46 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xwsm1B5PzDqP4
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 16:16:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1561443404;
	bh=NGkVWif9uvbEn9AjJTFqLXqP5IU3qy20nPP6jOsspHU=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VdAVzQID1J2PmnHGgiGRZUzEe3BmfW+xr7hKPAeD7SHsUrJ5K31eabNZ/2s216Wnz
	 7ozK/ct/u+DcgRRIyQdr8dLzrgCw1oLuIZHvMCkwXPCPB/BqMlSfcdD6/9JOk3Y1If
	 G72qJbsChBCRDB3fCL/O2llN/6Q/76cokT9G9FTXXmSUst1pKEwW8joavUa6BRNQBf
	 CJy2XrlZ8XmX1G11yo2xFLcPh/C0hyDz4Ocsjsj4i+yvyL5ovkYvZN5F/qbj7RFErG
	 5XR9ekKn1TI0FLMf4UiAMcjY/L04/iqJ89XKMRvSFBGPs+QcpXGUNZNuWbrjMGz6OS
	 URFr6poZSrqrQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="UqJz3uwr"; 
 dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Xwsf46RwzDqN6
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 16:16:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1561443389; bh=HNjDr39A0pgGIbR7haSq6lnCsX70F4NjDj+koGXlyMw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=UqJz3uwrDjtb7K4P3ZYqRb+NniX8JPwamSojKW7UjiWf+CLBvSA9w95q0sLoFOJTSIPGiG2zMsk7iVCZ8Rfe6EBrwvnpDUNVBP7JGJWbtPlJRmnONuTZY1AHxRP67sZNmpimdLCXXbMRlUYywoDoFQULfbSGxf7fF5jYP7OUpx4QZi8pU2TRK3ogD4qFaPuTZKuABRwH1dmCfMTIeyKpjHvfLv+r3xYqQ3P/eWz7toM7I0avh0n3we6n4YQeIJq6//weHgfGJbTV8B+abDcuFniF3ruCdEHBPCwhq74WrB3H4xYcFa2LXIKuU8x5dfWkFNyYbjQV+EUQlAPkEqI2pw==
X-YMail-OSG: 5pF7.FQVM1kRVETPvEVJj7OF8kdj_b9vkecrEmJM.5ZaL8SZ9zMsVj5CgP2TBhh
 cCq5Iyz.QWBUArOTjK2h8LdxSfxQ52I4Cy2SZ2yVbiSC0SSyCtDsn7Q77zPF1hrYnbHMLazcH2HV
 8U6UXDRYl2k4IiuOb2.h5gX4xWIg.vEope8T_nxLEP4MrZL6iPTUvIxmvifWjP1Cv4.hCV2H6Rqd
 x8baVnNQzZgm6zzzfNd1ZmNvpjouKYuIxGm2BZdCvk8Ik_1aokulTMOk1KqkGtS8MnBx8ncmpNtn
 XP54vTUfaXKb16BEer1KPAS7pNXNqGbPYGaqSWjnQPXBkDsmhF1JkRrImYyu0p.hF05Dhon1P9up
 eTmCwOZRdUeElwj9rYAss9qD8RYI6WZj0Bl95se3MdzA8nDrjdC4FqL1EuyqqwenOQnnRlZTIc9d
 Spd8mjXE3SO6EmjkZPqlt1JjjeeRHD3.QoeJ3pBZds4hr2hGOjCwD985Pcf_kKfG64zNr8iR7jYA
 bjj6iI6WmcLYX.Pf4mg6Sfp0ghLAb4kFEMcrKRR3XLxYVYZR9uqCILjJ9fQtFpXbHjgGO.oEdSAL
 c3MrY4lJfk10lty0ATusrf72Un74UCMh2DQdkhhqNjg.h0tlkEypWkjidHQBiZlyXVngvstep1Qr
 vLq3AIL3Jy_3dFSptG2KCI5yW0soxLmQ348_2yUo5FKwZOKWU5Ii7onkf9XeeDJlIpv1Vo01VHAj
 8BFGyBvgquT3pKEdHL_31V8M5iNDIvmsohsZCX2nTAYPESHPU6STNjVAptHXep_nwZb4Xi7xIB5Z
 YOQ1_GjRkOmouFABs1QwGroJ8evMbtQwM6W0GIoMqW71ovq5tR44iIo6x1hVvPptE8Gtz7wRj.cs
 7zecXrOST8trJ0PhHT6b3H.z1K8T_TN_xZ96926moYa.B33Vz34MxHvPfL9jBjsRMXRLJ4CJ5Y5R
 g1h7FsCKGkaBEgXCh_pzn6PjUmfeIomvaP7tYRNhqjlCQx9pEY0CcFCNTLs8QLhRxoIeDhSTAtn9
 rrx2rr.AKkgu2IZ7EPzI5H8.R0uNG19.mtlU6BiSdH8YmqhMFDPJwo0Srd_TLjd8DEVlShVP0KRk
 n9gHEzAuVNlx9JZaGm0Yzfc66l.s6eX1F6WnnIcXBJjbpeZsEiClvp0sHsHP8SjokDrK_ZJ2FPlV
 XZNJypKalmNrzR2O2CIucG7X7cYJ1PF27VWQn2BxMkfWJl8sDPa1R4FB.lpk-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 25 Jun 2019 06:16:29 +0000
Received: from 116.226.249.212 (EHLO [10.17.157.5]) ([116.226.249.212])
 by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 45444967269e977c0208064621de8937; 
 Tue, 25 Jun 2019 06:16:28 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
To: Yue Hu <zbestahu@gmail.com>, yuchao0@huawei.com, gregkh@linuxfoundation.org
References: <20190625060825.7912-1-zbestahu@gmail.com>
Message-ID: <bad38600-c175-4626-3365-75bd5ed4611d@aol.com>
Date: Tue, 25 Jun 2019 14:16:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625060825.7912-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



?? 2019/6/25 ????2:08, Yue Hu ????:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

looks good to me,
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>

Thanks,
Gao Xiang

> ---
>  drivers/staging/erofs/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> index e51348f..d6e1e16 100644
> --- a/drivers/staging/erofs/inode.c
> +++ b/drivers/staging/erofs/inode.c
> @@ -129,8 +129,6 @@ static int fill_inline_data(struct inode *inode, void *data,
>  	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
>  	const int mode = vi->datamode;
>  
> -	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
> -
>  	/* should be inode inline C */
>  	if (mode != EROFS_INODE_LAYOUT_INLINE)
>  		return 0;
> 
