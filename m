Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2814C577
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 06:02:21 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 486rvG1h9qzDqLx
	for <lists+linux-erofs@lfdr.de>; Wed, 29 Jan 2020 16:02:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1580274138;
	bh=GrZ0xgFwiGSiClfB3P/bZnYpNOMxJ0xeQRR2jmM/RI0=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bKDPKJAuAbqG8OodGjaiN5hW8AxaK6BTP9CK3lL7cLkiG9zpisB8KD1IdgTkxyPrX
	 PXY0kxsRl8ByXUk2c5HyFpaibIeU+PoL8KuWKunGtJGB2pnCHS1kdc6nSLHm5pnQvf
	 PYvSh5fBa70nizeGFwTdWGMRtW3RCB4sVEvFDLMvA7Yk2dEYrV67AJeStp1n4Rrszr
	 WfuzFyAz/jrLL0EDof2zxO9dtoxstxhbrXdt6Bf+tIpZ9SoNiT8uYgxUxE7wOkDxSm
	 frfIT9iFn8lkfB1GfB7DLuf+R1SFIUzSV+D3u7R5dcwZcsQpnz3XOiOn9A1dyFnTkp
	 SQ1dBQNgQ7FSQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.32; helo=sonic315-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=U62JjWDg; dkim-atps=neutral
Received: from sonic315-8.consmr.mail.gq1.yahoo.com
 (sonic315-8.consmr.mail.gq1.yahoo.com [98.137.65.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 486rrk5jSTzDqNf
 for <linux-erofs@lists.ozlabs.org>; Wed, 29 Jan 2020 16:00:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1580274002; bh=P8neKj0RiWYzN9Sf25PaKWhrfEy1d+ILhL8krLe4vLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=U62JjWDgLXfE45zxH2UWcUbC/swyjKbsY1e09rY2wgiQCk7PIXHHh9xvhfYsVyZ0ckSOnRCS946DYmYZ7rIWutpSYv61eXjiKJFqB9wOpiOKhcXP+3Q0b/OWsdfUj1OkiN8p4fo4hXtURwUxbt4FRJeRkLhPA0AJd+FxQuFGysB3I7BwaX1TubhPj65IpcKnVPcxrHJ+EG1xAn8oyadvuCNDkOg+7JepWTyuHdb4AG24AXUiU1WUsDIzdrNXxaJfI/jvDDjdX5vdrHGmNeMXpm5dCzML9maC/dstYT6ovVxe25hgvd1xLO7roZLeJBDBTSKceeoo41CBX+qpIO+jiA==
X-YMail-OSG: ywhRYUkVM1ncvYLOp2p.tgdsr7yzbA0qUDQ0FlPRjns3wxmizY8SXzo9Xrbqs0U
 1n0gEDJrEvH1HpqlJuE.6EGv2oiVHxLITKJT_BFH.gjG7ASTfL_ilPhkEm207HL_LEIrUs0B5zL8
 CumF4uOKhG.VpMdi.zw4bE6Fla_qF8RqhtUhYDuwTLjGGGs2bCr52bmaiGNrdqwucGxgMScELY90
 3IOzf8OQidiC2vU7Lv_y92AnbvbXaZmIpKfpXT50.yt7asm75iB11lUcAAIQWFeGSLQZR_lweaQ7
 7Y2XyWPTvWEK2MggZEQLkYPkcOm31zPnHod0iXqJDid6WhfDPX0koRjT2ZRF0xGTn8_7C6Ar222s
 5SVpQdMyg1PJ1QRXL6kpLdrpSNhKFU6hhobAsNcSBiWhuJAVDU.GxqbxlrImsd8ha8kKqLOA86SI
 gc7W3rUVgqRgu4LIi76lTnTIcQsezM63any2ueJDuWKacWQYxol3DBsMCiszpeGjVWLepQkdmf._
 XR0ltpO4ggwA_0m2SUcmo1dmbyOyUHVpqCAxklgBtYrqIBnlmVqM4hKc.WdqQuk7sap3BCmypJSK
 S6OmoEmq.1JjFycSN4PVR4UdzS0UPlhVHgp79kCwT5qxPh_7pZymInNhmfv5bsR.w2gUR.nxAMPg
 qcYBOh8deOkogOnCOccKIVj9N0kyxXDN4upiQlH8O6SC3a1O2ODT5Omh2JxUFyA5skmD1AboMSFw
 y7_1gIxmtmv5D8vQlrfgaxM8lKlOiieaOEKvn3ZjO2RgIIXJZaR08HGLyMdVencMdLeW6RhX7hrJ
 iGSSmZLKuWUYcQmnkUu84Q.VsSjaw_faXH0K.J4BDCJYR6njnqgWpyJoKdR.gVxFzs45exiK3MNP
 P4Aggj7y7MppCE6TlhC.NxqQ2b8Yevb0yUw_uNi3hTtgT6oroRkIPlG78Agaqrd.k8wGbZ1lSyHY
 ow72rMIwSDN8g8cgxqCD2qwi_qUyfy_tf5eBfEmiF7MJ52sFnwyhiziXC1HBdEY_P7J0fKeBQ7lE
 6qfaRtVWR_BFWb97rFPlZU67hPK0YvN_cDukkE.nWQ9lKdOeTGWGtKERgW.OQTG4SHEVIQ57WkST
 led1DRi.1LilnY31CheNkeXwb_Bt2T2CZV7WPH9K_aqAPX17eDymDxk7bR3LGa.Hou78FI6U0VCv
 bYJbdKs1s5_KZRls4SXuQ6_JxV1BbUpV7lBYU6dRgi2nf7Vs6_lzZ72vko0ITpnSeb.4wgUR3v28
 untDmnYwIyRpZxCNePiLRGtrgFljL.sBTry28uITIo4kishNCBreu.dgY4YvOMqVBMB1Yei1kHJI
 fvJ10Tgwsq62IGU4YSG4.YwQkPnWSsRc.kE7lw8wfKrsY19IrHLRdB0M8IKP6NErvuckMwM38Lci
 pT20-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Wed, 29 Jan 2020 05:00:02 +0000
Received: by smtp410.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID db4156b4f5912a92be6f99100f137143; 
 Wed, 29 Jan 2020 04:59:59 +0000 (UTC)
Date: Wed, 29 Jan 2020 12:59:52 +0800
To: Saumya Panda <saumya.iisc@gmail.com>
Subject: Re: Problem in EROFS: Not able to read the files after mount
Message-ID: <20200129045942.GB7472@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CAHmfoRm7xUwuXfTZ2kr-x9fs59x7b707t183ggbLEtEyO_wznA@mail.gmail.com>
 <20200120073859.GA32421@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRn+YjEwxmZLTeDVN9Oja=7QTi14oEtpD5x7URT_X9dJ5w@mail.gmail.com>
 <20200122043655.GB6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmfoRmXxEXqxJwakbQZmMz62_7DNai3KVzGu=U_yNEgYQvG=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.15116 hermes Apache-HttpAsyncClient/4.1.4
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

On Wed, Jan 29, 2020 at 09:43:37AM +0530, Saumya Panda wrote:
> 
> localhost:~> fio --name=randread --ioengine=libaio --iodepth=16
> --rw=randread --bs=4k --direct=0 --size=512M --numjobs=4 --runtime=240
> --group_reporting --filename=/mnt/enwik9_erofs/enwik9
> 
> randread: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
> 4096B-4096B, ioengine=libaio, iodepth=16

And I don't think such configuration is useful to calculate read ampfication
since you read 100% finally, use multi-thread without memory limitation (all
compressed data will be cached, so the total read is compressed size).

I have no idea what you want to get via doing comparsion between EROFS and
Squashfs. Larger block size much like readahead in bulk. If you benchmark
uncompressed file systems, you will notice such filesystems cannot get such
high 100% randread number.

Thank,
Gao Xiang

