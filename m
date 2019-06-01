Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id EF346319C6
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Jun 2019 07:39:03 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45G99J1JZNzDqcJ
	for <lists+linux-erofs@lfdr.de>; Sat,  1 Jun 2019 15:39:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559367540;
	bh=MFtfphZxtnvIm4lmT00IHqEnse8GdC5msmBsrnfyTO8=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=WRxzpP5bAwzh01yA6L53GXQtIsOYgyxJSXsS3pRkbawqHgc7aPDfcRxrgu5zCRJLb
	 mnTOxo7P72DG6l4cLYLxCIqFIzvECJTvTeqNQexjvacJGHAlwSRKhx32f0n/Eo4WkD
	 AuFsQnGva4XngaLxMGA/rnfEDi7k4POrCNQmKIzf/zQ14r4rRGI7w0PkZCVPI18l9I
	 o5lq1Ug/aicVqtWkLKKWGc2AYha7kQ7KXT7r9oZm3bdm92rmQ268FxkHc+LPjGscnN
	 M+slHXeLZhaBcrovS4GrypJwbD0Ta/EofdLgc+AVneEcs5FCPGxqchWvsBXjlL4PE0
	 mrEzd9+p+oJSw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.98; helo=sonic312-27.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="VGnwLwR9"; 
 dkim-atps=neutral
Received: from sonic312-27.consmr.mail.ir2.yahoo.com
 (sonic312-27.consmr.mail.ir2.yahoo.com [77.238.178.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45G9985YxszDqRp
 for <linux-erofs@lists.ozlabs.org>; Sat,  1 Jun 2019 15:38:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559367520; bh=GGg9lB8qSV/ybS+SU+IXIkowXFTph+v8Y2yjjfNKELE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=VGnwLwR9z0sfcavsvu/92RRmCdVQNGfjF/yyVHe/XHyyDP8QApASJCwoNY1TWAuJJWEq2WodASaFTWIBPaZjJTvDPmkP5iRYk4tZbBQIZ8gn9pOwvDHnjkF3q166Qcwy8Omgu1ar8j5270weiBdlYMHB0HEqQjVc1XbTixxFTId0cJXrIYQCJM7pX0odGZjb3DQCArlQz4SqaiHpOdD2PbRmLg4K1yrdH20R65KN8KHO6IP9WPLg7A9pMFBxGPUGeCV5ZFKufkn6vihli7KhvLILS2l00KgeEVH/CuJwyLg66mfxI5Ds/uega7nY+9+vxjhLsZKzqUqnRonBL1JtQw==
X-YMail-OSG: eaYdtvoVM1kRhd0i9rpA2h8Z9PvQXjpb_B1y2G355Z5.yHSS9uTgSUOSCvD79oL
 4Nj.QOeiDBX9VHTlKcKoOwVA2V6k_5eIlMIkyrn0V3lb23JBAA.nWcg5qLB9UsSq9WbBUXJaPXVq
 fkQGLhOyX6JQirVFukkhdpbXTNMaegoU9t9ZLbLb9xRzUDVYu6B45t2ArqzkeitfkeEKVED5me5h
 buJS376ikt_KdXc95eISPScw4dc6kap9NLrCyn1d_CmsVRsZcFw0Lf1NngERqBRU5eMgK8uheyED
 yvmnGUHumPJUtYVtSqFmraWDtZ58I37VgdWEl6vo7C6Utb4nxFYypqYFYEJlScAGG8d3fZN.5wId
 6BM05Dgs05vhMb5g9vPtHHtitKHMDNUDVLW3f4I9nMuE7e6BMM8eEFE96WWKycN1UvSnY_0oYnLI
 KRHOCwrKS8bg6oJdy8wp09wRpXAZBp4n6yKXzW0_WsSW6whh9wytUdaNbF1J6NYezyZl0ckmUOBL
 leB0yWr6WAKshEuC8F_I83UmDmIQ1b9_mcROelzt6tTKn_MQuV3UDjJ03d4mUXmwpe5_YdK5JQ42
 1Q.vqA.Om4Fr19.zDKtCZetxMTUrsEta.POFrfZ538EoyDBF1XBxHGxNRHK7DIb9PQnYiBZN24vX
 d5BbWEisWSG9dEFWWgEcH2AwivOdYDLkZ2s2le8g9DlA4KuZseBrhA5tbkMZtzjWlxvLJxbJvEjE
 RTPl2IouRkV6O3_REnjVf8DysZjVfWCEUxvsinhxo4S73BLIQbCq.CR0xKqqghwM.qJVVw0oxHPi
 G69agPnf4mkO1ewDGW7pRPMGJVbG0SNMwfmqsByBjs2SFGI7M1mtflssBagI_y7scejygWBAz_qv
 MV394QjholnohzIbvvSqERXMJkdLVO9r.wwvCsE3lxCkKOk0fXGzio7AV90EeY08GDrDwwVkyFxD
 Sthnw7pCv_QDmWwQh_z3H3m_RTmOuxsXxmqKo7cyiAEGGApXlVZmdqB47zoKFWNFeTD2Vev.53V0
 DYDoc.bp_DFON1hCgrG6cndNxZLxwgVSncs.V6bN93xxZy3og3FW8olZyAdVtwAYKmWAKBx8VnDL
 DM5IziOJaAm529eEVEZ_Yk2mBdIK1hJtLAZPMD279YcWglKcjbAaSQ0d6nSzbruyPN9cy3hBg1G3
 wLQkRcZnYYdOVt6lt5ll.yhCJ5vD0jVUPj2qZZYHzTmoUVqhE7g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.ir2.yahoo.com with HTTP; Sat, 1 Jun 2019 05:38:40 +0000
Received: from 125.120.86.223 (EHLO [192.168.0.101]) ([125.120.86.223])
 by smtp412.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 42e6c6038bf1266c44d226ba989ce0b3; 
 Sat, 01 Jun 2019 05:38:36 +0000 (UTC)
Subject: Re: [PATCH] erofs-utils: correct --with-lz4 example in README
To: Yue Hu <zbestahu@gmail.com>
References: <20190531092722.6708-1-zbestahu@gmail.com>
Message-ID: <852d84fb-8073-0f3e-bca5-2716788c8149@aol.com>
Date: Sat, 1 Jun 2019 13:38:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531092722.6708-1-zbestahu@gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: linux-erofs@lists.ozlabs.org, huyue2@yulong.com, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/5/31 ??????5:27, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Option --with-lz4 means LZ4 install directory rather than LZ4 lib
> directory. We will meet configuration error due to wrong path if
> setting --with-lz4 to /usr/local/lib. Also stay the same with LZ4
> help in configure shell script.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied to mkfs-dev. However, I'd suggest to take a look at new
erofs-utils since I want to mark old mkfs.erofs as obsoleted...

Thanks,
Gao Xiang

> ---
>  README | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/README b/README
> index 9014268..97eb228 100644
> --- a/README
> +++ b/README
> @@ -19,8 +19,8 @@ Dependencies
>  
>  How to build with lz4 static library
>  	./configure --with-lz4=<lz4 install path>
> -eg. if lz4 lib has been installed into fold of /usr/local/lib
> -	./configure --with-lz4=/usr/local/lib && make
> +eg. if lz4 has been installed into fold of /usr/local
> +	./configure --with-lz4=/usr/local && make
>  On Fedora, static lz4 can be installed using:
>  	yum install lz4-static.x86_64
>  To build you should run this first:
> 
