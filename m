Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A304A2922A8
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 08:53:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CF6st5pXjzDqbr
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Oct 2020 17:53:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603090418;
	bh=LRkzZHN17hATmjXLAfMAsXW0TbdmVf2KNYjICeqqrqE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EKltSUxwl3ikKkT7AtT5h9s6BqMqWbCEdF/HWo1nndsSc5yP2GlNAyFTps9Geg+go
	 AeBKJiKRhSfsUwj3ESnsuQWxC0HhTBcJLNpWsj57T3CTC38lAQpbEXlbvdb4ki/ZPH
	 Q5MFVRoKMQhz4jSFTHfYMi/OySrPcuiqsrRxogSbcyFlcLU29FC/bkXF6/o50f+XpJ
	 wO2BxIlVdjpa+lw0/08tMGfEU+u6l6JrVkQT1zCsvNaijI/L+BVZXDbeKrHq+71jM+
	 Mo949xFwk80NqKs8mYzrFlJT8+OUYF+xD0JoAyk31PGuSmBow7LtR8BTI7kNV6v2cW
	 Cgyg18BQQA60g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=CgyalStd; dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CF6sf4mvzzDqGQ
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Oct 2020 17:53:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603090396; bh=CKj+XWC68kL1d4GQCIH7hOI148gOq6xTL2bLNkizx8U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=CgyalStdO2crt2CB2tJ7ijN3T/DHvEX5acefGcejG4l9I0cFy/OLVXtsp8VOw2NJjghtwohXjxcM76/salDntdzuhNdhudgh1kLHi070al2yDUhLfSCegkyDTgUsFN7WD9lSBWElKVzaNG+vrqGlSZFQpmdrJaFOyyxv96nF2f6lj92mTVZxNPNhRixl1lWDOVB0by8lHogxxgukazHZ9Xj9irX7QSbBIf6Dxz/X/U68D088AeS11V9zgzefQCtbUGYCU7G0jsxwzFjfjDDs/aMEQ82TcTkvA0VodwlFQR3WMAucmZ4ZSiA9EwSh6lJWTNmHhD07X8Zi2kB1Z2dhkQ==
X-YMail-OSG: h5vzRrAVM1kbCgnFoFcoRthVfG_Y0n0rCC80IXGFoOB71Dna84EDpp5A6.jY4Td
 kqivUT7K5zzABueH_H2ZD0DXPhITKJBIawn6ORRnsjNnBQBtY5Zqbtctnzqs5IA9WH0LUliS3Ptm
 VE4a1g31SVAX1wGFeBWylFtoMCaw8Rc0l8wxkRJ4XPXDAS8z.4ei5A.Q_QC.ynct9jMVKsp7Sqsp
 3LuEgJoCuyKQ7vgif1SNnIhpuoUI_UReLhtGmyD06IUiO0f4A.1pbu.oAGUQmpC_tT73gW23jXPI
 1H1087os5LUx8roH5oOxZCmMxkANbzqywQb.uFt198QTTtQw0YhPjhwF5nOQugfGDtxB2Bwhtf5w
 qOIDcVFJuzi613FLD0u7F8KEf2V5XpCkiU7uNuwekKcPsP4fJVnz7RPE6LdPM.7Eze356KfqPd_L
 H.aT5UX489BS_.OSsKWnGF1VexXgNC9WQ1gsrCmIF9vDW8R8z7KvX8kC5xWS_O4cBGezwMnA_I_Q
 NpsYyShrt6QC4foRYwEra9EcvS8sDLSe70pcwo4ni5ePUkezMhJNy3MCH2UniZkjBUeUjm.yd01E
 LnDBtBOUJzYwd5HY9AQsCgHl8k_DJJMCtOMSwHwK2gK_JEglr1Gj9aOP4KCQQSiP4nx8N47bZVMb
 U5ah3tqF9kxVp3w6qisMReE8jL45vihN5pabUVMZZVIVqUvdVyVKehkG2X58IxsT7pDvfI8cwyPC
 27B1uOhoT23MbROe0ifOpGfUy.pN8l8cVZESYHd43ff8Q4PZbebIEAJj7.cpbAI5z5w0aR.e_FGh
 FUh_RQkXmgUrCHFPuoxBnzFSSutofuYcKkKwj7bUqHXcnwESwqZB2Ql4tjC4EqGo1X8q7olr5PJL
 4j7iXV_YuD4WC30jyV48rcVtMJIc6dK._bBLjDYSHdeRU8r76IcjE3bUvRFLrAP5EshJvqhBriQx
 u3xLdJ80tf56zWWPVL3o4DFpKEb7c1U_y_ps3pPTd3iQTobZjTw9PaUt2Grh5sms5w7bZoyyyM_E
 bOdqOhPLDWYp9gpxh8Ust0njTwfs_Hx2hDTP5X3Amtr_JCCd80goxK5vKBLxWhwcnqJ3Dyq7mgGB
 KLabBHJoT93xjqfwf0tZ5mS5IQsobtNXhULEXT6jaSxtQpkSdqrRRkeg3VkLtiXXOBOXJ196R_cM
 CfRYbrKKbeiYBA_q9APGEygvBquW6IHyI6hqwyeYaOr9TaPx0xdo6Dn6yamx8TBMaH_QJnsogGs6
 rO_xCpHCuA89BmYBEmw7VgRFi0ol3JvpnuGxM4kRxAPlarowjBeFtHEh2_.S6w0Sqml0MaVX6oQm
 DJkon6dr1jT8d1Qf02ztUWnCE3bWl3JCQb_LtxsJ5X4DISQ7ESeiBSyL4zfIwkeSO6zz8wUcii0Q
 8NBx9.ZuXZAtCkWf5HFHlemj60YBUza86cTgGd0.iuoP.jv5Q4d2iy9TA0Sj3wtzPDVrhRrNp22h
 dUtsYa1up2F7PTerJPz_hdHJU11WH0lpGRaJkF..f_JAUxDNpCII-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Mon, 19 Oct 2020 06:53:16 +0000
Received: by smtp404.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 7215aa1fac895b568ea789aed290417e; 
 Mon, 19 Oct 2020 06:53:14 +0000 (UTC)
Date: Mon, 19 Oct 2020 14:53:08 +0800
To: Huang Jianan <jnhuang95@gmail.com>
Subject: Re: [PATCH] erofs-utils: fuse: fix the clerical error in ASSERT
Message-ID: <20201019065302.GA23392@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20201019044921.124654-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019044921.124654-1-huangjianan@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16868
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Oct 19, 2020 at 12:49:21PM +0800, Huang Jianan wrote:
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
>  fuse/read.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fuse/read.c b/fuse/read.c
> index fd70a2a..e2f967a 100644
> --- a/fuse/read.c
> +++ b/fuse/read.c
> @@ -120,7 +120,7 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
>  			length = end - map.m_la;
>  			partial = true;
>  		} else {
> -			ASSERT(end == map.m_la + map_m_llen);
> +			ASSERT(end == map.m_la + map.m_llen);
>  			length = map.m_llen;
>  			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
>  		}
> -- 
> 2.25.1
> 

Reviewed-by: Gao Xiang <hsiangkao@aol.com>

Thanks, I will fold this in to the original patch.

btw, if we merge the erofsfuse codebase to the master branch
eventually, the following matters should be be done in advance
(if you have some extra time or interest):
 - get rid of customized error reporting, use erofs_xxx instead;
 - get rid of erofs_vnode, ..., use erofs_inode instead;
 - further clean up.

and I will keep working on this as well.

Thanks,
Gao Xiang

