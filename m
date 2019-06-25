Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC252422
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 09:14:27 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Xy8J4PGqzDqNr
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2019 17:14:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1561446864;
	bh=d7RP3uaKs11eu+pGQMT1U8O88KrhynJKCyPQkSdro+w=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=EQ549u+j/Iy1sqiUhb9Y1acd3wq6c6wM1JBTk1H8yls2yOymnHgRSaM01I29IQqH2
	 22qjoR/hOIWapCMpLlGFrQbarzSv651vk1I2R4HjZD6Zqcgs4AfvLzxcBaKSrVXCZd
	 Ctf1bkDV2OJsun3vNLrU+lBq0R2+jcpqdPXAaD6Y55xXnZk9FV7AS5kApEjah0irJX
	 NGzJv26LVoCBWhtN42HDhNMXNtsE2Urb6giVFuJyftwpEP69sksqWtX20c5kaRrTgZ
	 EuqTlPT5gKjrVM2qj87E2cH2W8+hpu2nZd+X8zSyz2+oRIvraRXm5gK3bRzwwzXrxH
	 UF+YRcUqL/DFw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.176.162; helo=sonic311-30.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="DyqH/wug"; 
 dkim-atps=neutral
Received: from sonic311-30.consmr.mail.ir2.yahoo.com
 (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Xy862zwczDqDx
 for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2019 17:14:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1561446843; bh=rmRStfJ6bGLK+dQNCkpl59cz/tGBQgWaO/tEDwaEFS8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=DyqH/wugMlkJl3Nc7i25QvlXqOaHZlP4wXGA934gNOCU7ZWJHnotFPmwu/YJsmYMLaRtVp+/vlVegEqavjr8CRRpQ8343D4b2Aks+tMXpxhQx2B5znAJFggrLrcqiueNHgmObnGLJLsFUFB1skncEJ4XTkyxjaXPt4Tmzq0tDjNjCyybZYUEIu+PNDQ54vxEUDLYe4Y1aO3Rpy1rdOfLORpSUCJaAP+Jxvq206PhCvXjE3flpAg+N3TYm20xPisbRmdtRcOIEvvRrgHGxZzWDHUgPLYCBnwBiExu/37GkvYZyffKYCCS2Du8bRkS2dlUwcqkMooEf1+kaqj6PTeZbw==
X-YMail-OSG: 3olTnWgVM1nyey4WNsqhqzmcif.H3sIgRgMLNbJhgoFVlNqWqpisTc319DXToNM
 0EK2Ns1cfSFjUO3ZZX25b6zN.J3VeRkxQYyfhW3ly6lNdke1MYwvlA2yPVGwcmpCyWeeI9QVH_Tx
 KYSbaz9P4t9Zux9s2yXjZYbncjEPNyLA2yyKiITNV7kfDPiilsTTsgcrRM0IrGNR4m6hJw0VvWIh
 VXrUVXMVPK4SUHJSiSRFLYlz_KKwp07MnxVkF52ped2Q0URJhM4.2.0Ui8DMelzbmzSsYnoqBq7C
 vEP8h.O.QjJvLYnz2Di2fKtfac06mAe62rvJnLS4GJNkoScJj0Ub.f91NTDMTIVV3S4IRhE5x9zp
 ds3me.ow45R59rmZbLFzQtkEqOLaVyoaUknssHviIOwFLjGW5G.VUBeHNZr7EhTpUO6eFiiXdKam
 fOPY0oA_qRQxgvSP2DswtfIjdLdK31oj54diQwqaJ1zNhlisMhtP0n2Vswsnp5v0lyoBdS5B3Bqu
 A9_dxDTMgBs8DFuazOAJueabSkyG5SJC2X9kqOWq1Gygcz7RO9RY_ldjschYQpI0Yq372MzbNbtL
 iSMEPTsjHsnXrByrjHHg0ymtB8qlgo0AQVx3acSKeqpGl.2qNQi3ip1Ckwx82K.Kv.x4j1_ba57o
 PRnsMUcT88R5BiZYC9AwSnajN9NiEPMw5Swpw7BPYvPAdm0dFA.ScufSwL7S0ICTlspN8TQKOEir
 kl5Kfx9IF6j8KyHa5CuWeZ_jL3uoeInsG7eZ.OfvpPHaUb8V.KQNjaaOn7lzHVKsxfDCYAGa0a7x
 IEohOlXxvZxIbTb4eTcpox3vDkCgIdVRKoKpStLsQS3iyabVbAbZ4f.Qjl6_3jFg6HPnjeuqxvsP
 G1TzCF.XMJ63yvX3c6f2jbt72BEnf9GBUWN_8oZg9Un04zpyehQCt_GYQtSIIovnuybNvs9TMkBB
 9JV20nTnnq_aZ8Ny5D6TS3EK.tf_3b6Xm7e4a6AZGeyhGqlbIjUzuS74mkagjU8evjvEer56dk8N
 t9oDJHtmrmoGU2XokJaxvBgmMVDiUcQZH7tTsq4fghqNI_FDch1IKgXzq8eb25MSwKXi8llmdqMJ
 H4PQFtb7FMk_IL6RSumzvbBnzzF.GcxAHyEEytSVIVuwsKekMfpIDpgrW908.7VWO83dH1i4wx_d
 rVId3WyVimN2Ni5UhEH9G5Gh5RLUq9HLJ9iqWiO4F8SGj4Ted4rp1rHJJ
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 25 Jun 2019 07:14:03 +0000
Received: from 116.226.249.212 (EHLO [10.17.157.5]) ([116.226.249.212])
 by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 450a10a1a1c5d570b889f9f9f41f938c; 
 Tue, 25 Jun 2019 07:14:00 +0000 (UTC)
Subject: Re: [PATCH] staging: erofs: remove unsupported ->datamode check in
 fill_inline_data()
To: Yue Hu <zbestahu@gmail.com>
References: <20190625061431.3964-1-zbestahu@gmail.com>
Message-ID: <afd234f8-4cb3-4481-695b-1726ea7ad71e@aol.com>
Date: Tue, 25 Jun 2019 15:13:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625061431.3964-1-zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, gregkh@linuxfoundation.org, huyue2@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Yue,

On 2019/6/25 ????2:14, Yue Hu Wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---

Is there any difference between two patches?

Thanks,
Gao Xiang

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
