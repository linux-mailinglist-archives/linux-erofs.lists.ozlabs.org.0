Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF21A6A36
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Apr 2020 18:49:06 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491F27452RzDqMv
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Apr 2020 02:49:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1586796543;
	bh=kFg+wHDUHmAuDWOSsun71hpT3WgTNsI866dvfPGK13A=;
	h=Date:To:Subject:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=g2LZasiVn4QZ0ekP6MzlgyRJtTBbgf6WXwNpwwW6oJLKMPbQyS2Gl3FCoXysfT6sH
	 BZucMPXSlsie24GnAhdlv78KwuOE7yj+yqNWJrVfkju6ypvSx7dmYod5TZ1S+Dsfhq
	 0JBl8MwoPeKpmUhPFwuhzw7faAqGRcakectO3PbBNMr4mwfKrXRkyLxt7Cnni6W33+
	 nkfi/T03bL7XWvRC2qnyOKGFFOft/Sg8mReXA8oBYjIMP3PXbWYCQvtWR1FtQBU121
	 IN+JUYwgRg8A/nDCEYQy551qUiPmpn0coCAGfJiVuvPgzIpTX3q3sdWmgsIduTAlQB
	 PhjbbYggbOsrQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.187.59; helo=sonic308-36.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=G6N26eb/; dkim-atps=neutral
Received: from sonic308-36.consmr.mail.ne1.yahoo.com
 (sonic308-36.consmr.mail.ne1.yahoo.com [66.163.187.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 491F1q2gSgzDqLf
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Apr 2020 02:48:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1586796520; bh=bElmMGeGrTv4UdyeT/oxmt1v3extMJthOFW7mXr0BPk=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=G6N26eb/yIVXiQw0qE6W8f1AUrYzP2Vnj639Wh1dRrPcss2DmnvhpM6jv3pahSdqrFPJylW7ww6buFHDad/XWvsA0ORW2x4Pqk2m7Rl3wB//SK75W/34y8J46ioDHOwyfgZuoNAirliNbZMXd2ssFqHczVm6uwjizaz8w4+roui8RAImkHC1G8HM0eLi+lIN+UpXYFFzsHxk0/fpUN7p1G+a08pwx9Q5aXfZHZH6JmyFThQVGq3uLKmzFlPLEIMb4NFQpKquxYjJdjfNPnsB8XJgTLhVI0idEPo/POaX9oGrUXioupjEW8jrcagzTy6jliHX7oUMzGd4K7n/idELdQ==
X-YMail-OSG: LNqYr_cVM1k37p0BEArws0j2SMpuYOmfY_EMhqarqChYwpxuxB8KFGB5vV9fJsz
 iIhnJb3jaXvCGfE2aSt4doan7aJ6dnzbyn89vnjq_SV8cDsINa2Fqtq5gc4ss64xsowGwGkY0CFL
 bkDlKb.TBuK5i6h5kMoSuaco4ej32E_P1gf2QALa7eJ4GjX3kPp1EPZiOY7t91D7aYL8_D_qdt3H
 vO3CrC3b3OzsJM2iIxCQTrZhgw_xhCgXknUXKldyXSCljK.xwsr6ptXFP0ShFiClnDhnnzQSeb8U
 8moIDJ0FYYVSUa5fkj9bVqabZrzyVLc1F11Q19S1nCLBWPK3XhvJyJYWLAXyfcB.b.GvP2KFnYxd
 .622OG1af5W_BeM9zU.B0c_zanoiWMHY5iDCE4YL7hr0Z9_vvXrbkIdlZzinFy1cDN.jqFa6Audw
 gINBZnjZwlUDG_kWvj7oLaD6DBTOlN5FSKkY3TqJCvii_60QSyGPbhVDbzMpyoK9WrDLrc9Qdcxv
 vplOG2bPeK6hS1GT4th80ccQjURFsuAX4URg1Ud7Pg.Rgy5_m3ChN8gh_gPG6s6yro2abNq1zTVk
 5MiCxH5yW6Um1DLHst.PQPVBq0jsOJJINwuE52hU5csMNA1iS878f2XIdgfuJ80uGTw9C0Suq7MV
 jUQPvf7Jn.r0CPz6wIduG5MdgGa5MUc6EaQ9Uk2BgNfahC6Cjhlm1NdcNMBrpoQKcFCw2MeCoqOX
 XtKpIYf0Cwkg3P_imu2PoQSeZEBtLzT7fk1O2mdzN7Add.8_6nITJWcVQ9tLbKVk5cO0HzcmEX7G
 Wk3y05Z.DkCwSpSMcv1Pt2tu2Jm5sCTeBqMvJeRrc0sWL2q8Z_Hv.ZmxNrFPZ7yIhNm3tp7M33Oi
 YUy0yCJ2V8JL71R14dSZ9slsRCO26FHABrYpmPfindFDov.JMXs7_zdnKFTDtVehI.Pf1xUAh8WP
 eGk0o2xRK12vs3jQejL8E3_HS7MSqPRXf9.2YkjO9Mbn3MXzicXwMk00MgoB8EV_tGnMZCtZIwYw
 foZddko11qm3tQQONrDFvdKb9qax0V2OWdPkraYbNgpukrtllXThKRQhV2u34MzH3hmr3_urqUQs
 ClkLC64opRM.mNzxEj.VxatPE83c0L5SREGkqlyOHuHTA9bofUTDAb02wx7mVSNIOH8CIyvO8GS_
 71HVoS2qnZAM_.wmbp1Lyyow_1hO6MGdI42Gg8O2AH5E5faSJVUDvjfsVcv2SiaiCKIOZvlOKCxX
 v9jYAeL6UkGR0Yy3ugJ6EPuNc1WvWQi9gkbZ6aNb7RshbfeE_dscpY1d691.OuEZa2dVD.of3eIn
 DqS2tCYzshoHXS.Hq5wHrwSAUsFwh12D8q0VPrMoQ3E0aTchM7X7hCVNafw95qXWfliTAppfKhiM
 EUiz_SVqm8in1o_lrVJUImDS0i2fBFlWRye6G2WZC.oU45UJJqcfnqc5_0WiZN8Ktf.JESTnVovd
 BytjHtcq9zOOXZcUjJ_3yQ73uipcIyH3TcxKvspLA2cqw95M.gQwTZc76yQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Apr 2020 16:48:40 +0000
Received: by smtp424.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 700b38ef91bca85d70b21427f6befc3c; 
 Mon, 13 Apr 2020 16:46:38 +0000 (UTC)
Date: Tue, 14 Apr 2020 00:46:08 +0800
To: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: [ANNOUNCE] erofs-utils: release 1.1
Message-ID: <20200413164544.GA5578@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200413164544.GA5578.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.15620 hermes_aol Apache-HttpAsyncClient/4.1.4
 (Java/11.0.6)
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

A new version erofs-utils 1.1 is available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.1

It's actually a maintenance release including the following updates:
  - (mkfs.erofs) add a manual for mkfs.erofs;
  - (mkfs.erofs) add superblock checksum support;
  - (mkfs.erofs) add filesystem UUID support;
  - (mkfs.erofs) add exclude files support;
  - (mkfs.erofs) fix compiling issues under some specific conditions,
                 mainly reported by various buildbots;
  - (mkfs.erofs) minor code cleanups;

EROFS LZMA support is still ongoing, and the previous preliminary
progress is available at
 https://lore.kernel.org/r/20200229045017.12424-1-hsiangkao@aol.com
and
 https://lore.kernel.org/r/20200306020252.9041-1-hsiangkao@aol.com
some minor updates I'd like to send out with the next WIP version.

In addition, as discussed with Lasse before, XZ Utils liblzma would
probably support fixed-sized output compression officially later
as well. But it may need some more time then.

Recently I have little time for features due to struggling with my
upcoming English test which has been greatly impacted (delayed) by
corona. While I'm still keeping up with community by email and
available for all potential issues and/or responses if any.

Thanks,
Gao Xiang

