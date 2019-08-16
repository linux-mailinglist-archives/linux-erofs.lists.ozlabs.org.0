Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B789019F
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 14:32:58 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4692lr2FHlzDrMl
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Aug 2019 22:32:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565958776;
	bh=VpM9s6HEYTNyPCrsQoLLnnUPmrng3jZEC3Y80jysXuI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iQI7IWyKAEL69KR7kmAVte6KpdiUw5ap/mlPPEPF8r7RcvgBi2U9EphgNXVZtVlkE
	 p6uzev8DU+8yU1PSj0bL4BIlA2WxFZfxvQKbIkjzniigX6smfGDBTCgNKGrbZ1f2Ns
	 i2mg9WBZP73Muw0nBH8zIb6M4ij9680O4lD5DJhuxLThRAoBePn6JopB1S0FNlS1ad
	 a4XANZsQYeqHBVWW5oq/NfR8uNGG5i4tn1jkdXJgJhyEqQQurnqkDWCAuH22TO/CI8
	 36Rr1RjX1gYBmzhWVH2gvcCOEqhcyLFUSaXSWviSzInTeGlrjg7gO7ROGuB2RXgvjI
	 t8smLDzWwlO9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.82; helo=sonic313-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="jP200VyP"; 
 dkim-atps=neutral
Received: from sonic313-19.consmr.mail.gq1.yahoo.com
 (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4692lg1y7NzDrC9
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Aug 2019 22:32:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565958758; bh=6uj81wZzSOLKlMolQU+bWs+AqW3trxGkNr+wX39sdF4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=jP200VyPLcdajWJhR0/Y8771QwpOo5dszY3lJpb4rQblqco8YrbLL1ySacmCrWb4tNehmSoVp66Jbtfy3AYy3O37SdgujBIEYhvOUASAR6d5jeofXAUkQnG9OtEb+mZ++mrE9M1ZPGLp9u8UUxII9BtbznFCOeD9Jr96XxmnUr18CYC5HaHLKb/luFae9dVPp5LUCoQB2MlVZEIDrNheBA+ZbN7nKXhLSZJD2mi4VkuoAD0AXWKMhPdepy2oucm4hD0PBk8n/lQs24rR4aIKUPRnoBQvsSiIOU5B/5Vdof4qhGbw3nMwtn583nmijTjlrrR+V/fgCJHQUKnt1/Q6bw==
X-YMail-OSG: 2RAHBokVM1kNnbIXNoBLIqkWtO0oBfrUuqk0AZklYVDbUYfUMinIm1smy5Vbmyg
 v3_xIUMkZQ3R4h6GP8LRDrZPCHXzsKBdP9_jnNuHPHtiFwK9Gg91uRMVBeFp18YN3VLfkd2X7NEH
 kWjIynFqRl7zBrZ7lxhpuYikDuqJacsTBbaGmihAeie29HCk1f95lJE0qPUxqpLNNZUSNVI45sTQ
 DcmleiQto1wYoXjTHNPQZyXEdHXRyBPRYJ7raS9qhPqNFNNHwnclgOST34q_AEbGtyIOA1NOVbxr
 zXoRVRaqlHthFHULPRGaxVnEAgkqzpwqlzfFXviWgpoYV44YWUjfCOEzaDy8v_UT9V4m7wdNBiV_
 qTOXflmKiSGK6wBA9u9k12UZBJ.HxjOjxywiIbKSbg5ayB6msXSceqqay3jYedgxcUH36Xb2mBbd
 lhAYNRdS55bJn6Yhntrpvj1.yAY2QEwB3Qa9i6Y1sMuQFmnO.WEPlZKe3TRXdTvbRQV2aAb3cBMo
 S0Lm7dBNlnT8q.eWrcswFNUYsvOmPLt4tLcxUrAU3LTh.yvHNjztYMPNQ2UVOwMScofrgFP2Ct2B
 0av03KGysxXhLpT8zWggE9XBA.uGn8JSFb5uWpOmsKjZMcTUzzqS23K5UdWPpT9azGD8C6aOjrCU
 EAmWQJYI6XzWZANYcG9Jo.sDwory_4eB.kfBnq_WaOkCjS5hQoHLGouckHM9z9wunMZO9k6AC6pR
 VMofqGS_EpfpnpOfEB5ZBp_rLbySS8NomsndzIx2oiBPaDomREzpCgVv4NLmD3RzFnLG8dPISBpI
 UeIV2yLfbb8C890o7i4FvyJjh1QfgTNAb7yFAsH0A.NSDraOPK6hv2PPgGd9_fnYsHJparNAx3pB
 7kIASSmxd7ahjDl_6_B4maxwnc9auEpev1XLWbbRgOMtdraB1n7gHlgxTx_3.CP7TeAt9NFIcAmh
 E0eAI64GSvnWSXIwF0.UqfnAE47ydNblAKpugttBGF_z.5h7a.rMp2w7Ddc9ofAb5YY2GQCl0fOJ
 JvC7RAAVVh1IjAogf6dcmFOY.hGKCCLnL5YviFs0abAaegr8CL6besKZ639aNhUAICETiswF0gGX
 v28tax2VpPSEj3VEui2VyNqer4TJMZPYI7ciKQVIZs7C0ILe12CGJfDAPkaswlCyg7uU_Srz_CxT
 hLwjh6KrJjEn4_HOiEcrcV6V15uvTHzi.70LGwKOsFoRebTT3uLnaazMTcwKgKcUgnfQT74ReZg.
 LbKIEnpuba8LwEkga_FdGFyY2LQwSUg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 16 Aug 2019 12:32:38 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID e9d4efb6967fdbff6847104a48fc9eda; 
 Fri, 16 Aug 2019 12:32:36 +0000 (UTC)
Date: Fri, 16 Aug 2019 20:32:25 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: Fail the image creation when source path is
 not a directory file.
Message-ID: <20190816123224.GA24479@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190816085620.22266-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816085620.22266-1-pratikshinde320@gmail.com>
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 16, 2019 at 02:26:20PM +0530, Pratik Shinde wrote:
> In the erofs.mkfs utility, if the source path is not a directory,image
> creation should not proceed.since root of the filesystem needs to be a directory.
> 
> moving the check to main function.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

Applied to dev branch, thank you!

Thanks,
Gao Xiang

> ---
>  mkfs/main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 93cacca..8fbfced 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>  #include <limits.h>
>  #include <libgen.h>
> +#include <sys/stat.h>
>  #include "erofs/config.h"
>  #include "erofs/print.h"
>  #include "erofs/cache.h"
> @@ -187,6 +188,7 @@ int main(int argc, char **argv)
>  	struct erofs_buffer_head *sb_bh;
>  	struct erofs_inode *root_inode;
>  	erofs_nid_t root_nid;
> +	struct stat64 st;
>  
>  	erofs_init_configure();
>  	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
> @@ -197,6 +199,15 @@ int main(int argc, char **argv)
>  			usage();
>  		return 1;
>  	}
> +	err = lstat64(cfg.c_src_path, &st);
> +	if (err)
> +		return 1;
> +	if ((st.st_mode & S_IFMT) != S_IFDIR) {
> +		erofs_err("root of the filesystem is not a directory - %s",
> +			  cfg.c_src_path);
> +		usage();
> +		return 1;
> +	}
>  
>  	err = dev_open(cfg.c_img_path);
>  	if (err) {
> -- 
> 2.9.3
> 
