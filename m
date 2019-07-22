Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C37056F
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 18:27:51 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sn8N2nCyzDqVD
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2019 02:27:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1563812868;
	bh=kQa01CaTWGI40EM1yuGMOcSX3Y+Mrpjt2UFH9MLYUr0=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UcrMrhA7j8Myu7B8UA4I9NGCTkmkVn/gFFV9F3TRoh8KZAW+rpAtb7ju5T/4RFHNf
	 u9B10SIcSjZaElWeNaIgg/ZtIaODrgXMYZJnJlfRRdRe26luRrroTlQC7o+/bBAPfM
	 rIivUF20x1wpw1R/Ikb2+njBAIUDWn6PsNWUtcnuyD3G8ePNIK9Xdbl99t5gqb7GKH
	 lczEK+JbQPvNFSyR1cCc/+TJ3i1gZEvGjnaywJh2GbyFxboG5LcOrahMpPPM4vQtEq
	 S3zPcg8ETVs9LqYaX+j9Ywsh7MH0phCItlhL48W/4fJK1UJ/t8fgX2ESAkxTqakiI1
	 VFBnH9Vjpp3Tg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.179.187; helo=sonic313-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="PDoIL05i"; 
 dkim-atps=neutral
Received: from sonic313-20.consmr.mail.ir2.yahoo.com
 (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sn8G0hRHzDqSH
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 02:27:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1563812854; bh=4tmyXeIY4oqFIVBQrFKdjj4C+ZBVcIroyn01PfQ/hHM=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject;
 b=PDoIL05iiWF7UEY97RncX2mn5BEWGfVbh0EBTCk+45qefwCsQpBR2hdpoCu8ra+Rq7LpAqFFBDtGTpQLo755H+QAUR0z4wVOqck/uIIUQx3QFItccWtsyWCbwVWSnKGLnQ3VxEFLUhnPvJcdusnTGubs3PL/fpwTP+xwPYxU4KMA7vffNm7EPA0T0qPt3Fc+J2nhWqoaJ6c6Y1IY6vOGomAMTJen3YQZ43yHk5s3co8rnEUS/YfU4F7l+dpVsvoN8n25j8u2x8yOgBWwm5o2kDH/6E3BJ2hjuMPDUQDAPcCtPuj2lfJ/GsQy9QiFjdrR/NoXXYWmYF0aQhQumIn1vQ==
X-YMail-OSG: kJzK8G0VM1nKSd0411aaQcR1cgN1N9H0NE1Il2FHTI9KnNHDofM4LaONFl1lApv
 Vyh8jk3edFw5qprRvl.92gaApjmfttnN6y6CGP4kx9ocxQZaKSqZhXvwaPQNMlXNucX3wwKllt4w
 ODZNWYmjZ3Fa7uqIkti4UqNl2Sn91EqI1VvpI.ikwSGpZZu1MhspOgtBFXeXaZJkZ5gHctBAHwit
 mR2dN2bgXHnJrPar5iqNYwTKPZL01Npgc6.UXOHl8wE7zcCTBfiMXVeVGbYqXsq3XmPYXlsQV_rA
 oXQ2bGuGeMmN5sxLIMim7NEf3Q86k7WiMy4ffi8wE2sxBzRoovZQadl7Tj9U0iRTgx4QHHA4w99S
 KQuBrfrz64khcZHTHb_sphzRQRUhwxefMk7hnc2PQkIqZsKPMKnkH7OMr3sR_8SrZq5CF4lbmELu
 587MFziqA8Ug9HW4B1zxBAJOPhtEyj947WCxnh928ne3N_2KUd5MM3shSC34PdMLfF1RLFbW_vFt
 AQK9V_6DepeByE_YTaVKrf9dlBrhGojuoYGcTwWd5zOL_K68f1woziDex_YkysKi_cIXOibYqa7f
 CHVlk.8BCFkQx0yMVfg.jQfyCoH0eYlmKJfhBx.A00Lv5LFf.0A5Tij_BMmx8C4uaiVOWielMJUg
 rF6BvW3eIWef2ANZCPqDq0SxfR00jWyf3g1Bj95Vg3mB1N1mo9rrrAeRFqTWFssZk_aDLuozfhP6
 wIT9sroPknqhOUale6sVeiGF6AvrOJE48TVytuKrJId0nuO9rzH9DgTIWOYCrS_2zTfg4wx0JJES
 eWpnGNG7zMPhfp2nVTqchZ0EpsWiLlITLbmW482a3NNarNeXIlZlmniBMarD6ogDqVA9qhrbWeBF
 CGkMFZUucrpZbUY.gBPxxdJjiCnrmdAyIL5h5XV9TyWvZjt4QodE9g8iv0NBnS_Auej3beTB7L06
 RA9M8eaKOrqGb96ad_um_DaY43jI08vs8MOrpIJrKms2MDOJGJBtOhWB8LZ4TFZ_oGz2DI6XcFID
 qF_4caa_d3B5OUL9LK4ovobNaOEH4js3T9nOIx92H4yJxzxYbiytPbr9T8dzgi_PBdD43zDA5GDL
 95qStHVJx7L.Mhqt31dJX.hnzthMVcuBOg3ekPH4ogu4uBh0Ux_F0xYTkTs6ESPA1vqkYyeIB0eg
 GGo3CZH2oGWdDwcfjbxNpINjZWASZbLgkk5ViHqc5k3821Ds0hZ8X77Q-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ir2.yahoo.com with HTTP; Mon, 22 Jul 2019 16:27:34 +0000
Received: by smtp420.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0f3571226556d2a71ae3b00089e7ff33; 
 Mon, 22 Jul 2019 16:27:30 +0000 (UTC)
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
To: "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
 <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
 <20190722132513.GA5172@mit.edu>
 <db672675-c471-5bc8-af15-91c1859e9008@aol.com>
 <20190722151226.GC5172@mit.edu>
Message-ID: <a5001fe8-217a-42bc-9257-45bef544762e@aol.com>
Date: Tue, 23 Jul 2019 00:27:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722151226.GC5172@mit.edu>
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, dsterba@suse.cz,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/22 ????11:12, Theodore Y. Ts'o wrote:
> On Mon, Jul 22, 2019 at 10:16:44PM +0800, Gao Xiang wrote:
>> OK, I will give a try. One point I think is how to deal with the case
>> if there is already cached information when remounting as well as you said.
>>
>> As the first step, maybe the mount option can be defined as
>> allowing/forbiding caching from now on, which can be refined later.
> 
> Yes; possible solutions include ignoring the issue (assuming that
> cached data structures that "shouldn't" be in the cache given the new
> cache strategy will fall out of the cache over time), forcibly
> flushing the cache when the caching strategy has changed, and of
> course, forbidding caching strategy change at remount time.

Okay, thanks for your kindly suggestion :)

will do, hopefully resend this week (I agree less bugs with less
kernel configs.).

Thanks,
Gao Xiang

> 
> Cheers,
> 
> 					- Ted
> 
