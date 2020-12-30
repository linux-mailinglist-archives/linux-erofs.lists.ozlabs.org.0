Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E12412E772D
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 09:48:14 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D5Q0q6CG5zDqHK
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Dec 2020 19:48:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1609318091;
	bh=yF78GraHE2cpb4git7+AksRuUbVmr0ScX384xX0IHD8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=QNws5PYEbhLhbjPFRJF+HTYXvoEYwmxFzU0vZ15tkBXh41zMswfVe4/HyYgUGRIj7
	 mYAJ92vPNpsjR9t5eNNqCVD1c19xkL2rg1Ot37GJkdOhz8vWqSTIFzAK26YmJNgoeB
	 tC2cGtblrIe1+ye3QoNbGUe+XCOsF89/EEywome3UoKGIt3YyPXFXPnNtft3SFv0pF
	 wueH0Ud35hx68MePr+Csb8cuI/gIdTB4ICtk+WS224UxzYmpoKLtCbdR2PrWk0dQ6x
	 EI5ltObk1cDb7WjhtSsx8EZdmIy5eUNuLsR5rQhp4lnoAE4P0qTA4L05/CCxwzVsny
	 wDXuIOPyIvf+A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.204; helo=sonic311-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic311-23.consmr.mail.gq1.yahoo.com
 (sonic311-23.consmr.mail.gq1.yahoo.com [98.137.65.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D5Q0X5zJmzDqGk
 for <linux-erofs@lists.ozlabs.org>; Wed, 30 Dec 2020 19:47:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1609318065; bh=Fd05eXgMGkfjQwLgn+8Hc3vSUI4Bxk/uGbu0E05ZC7A=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=Lgf2H7v1dgdwO2wpO1RoOYL7wHc/lypy6UkCrnMxC+8kHUtuZdV8/vjvSjhCVJ/cOxoQB/rmlBBIZXcg1DhizBfQTYX1NWhDcPl10noSLoyvcvEOBJ2NUaPSs8u41t9cijkxxN5cVlJqMGKq0FscMexHiIhwawfMrdi0WImpDbatKZxVm8InogY2FHLOBxWhBwjrzgDWhM+LMGT7G4Ks/HBV7DB8UgypFRd9NZ7F+PKOa3/dT6QvfUsDv28Ty1EyCJIsMNZOQTQurj8+F3MkORGXvIJ9qciUVZA54KI2lzUL22aY5CzfYYhtf1xTmCgl47Exadh808O/g1AuXcDvbA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1609318065; bh=6X6CU2FvxwFpZubla/ahqkXR0RqWaCunWBZvXBv2Blo=;
 h=From:To:Subject:Date:From:Subject;
 b=e9gu54FJVPA/5ksEF52LJYV90kDDvjHglgRN8XhzKfz37bYbf5w11BLMbpVzUCijvBDWcHlEDb7yJ4PGAzjCLd+dGApiKulELGX8TwPxqz2ZT5t9geUL4vhFAFFXhIq3gBHsgB57lFjch6gdUYPfBoLRAtS/wOCSm3goieQ2PtS3WH5w8gRpqFdFNFxlWyw81t2N1QNFJSCYrdfeiXUonWDtvm1/sAsRqKyh9AtUFL0D21hiNQiObmJZd7rSO9c62CRhA5z5ZlcCCN7OBntR+g4SHNVrkRsDs8eME86AF33wD7Qn2WJqz2d5ZJS3yA8mRHTrBE6Zx3FHtXgvlsdV3g==
X-YMail-OSG: omzIFgMVM1mSHH_kBPzjwWh.XNpp5PGqBShzmF.hRLcjgaNnqNo6Fr5Vsb1beZv
 D_EAMs4dNyMLtN3jHk_NdFkyZ0.MClnDlXSEXfRxUWeGPwpf_aBJflr6xnIElrntYPGil4FAeV.v
 GVnpGlmrA3Q36vBhA2Pu6PPBp73nKhIHVJFRjbxnnv._kBmd6fcCFpX6aMxXCft1ABSXY.iINZ1H
 SFl3xI4j6pjVrtT9wYT255c5iwmqXNC210FEmfdF2UdjZQcn_hY_weMk3LK2SH40TH6V3EWhknK_
 .UV_QHngSr_gz4PzX7atQoYMiwcZfZ6raClv_.p6eGzxDUWBjd5qub7PkoAvfJ0Yl067km6rduz7
 AW_Tt.V2NIOsWIPoJe96.Z7TGf5oHFZSS.YYSrhvs7djzY8Gfw.LEPz6SPsAdMYjQRWGcZW_BGku
 x4aeh97jhGxZc9MKRNaubOWkEfwB5eylXzlQZGHLkZGAbk1RXJ3OC.f89No.gHxoKm46nheVDBRh
 kPpBP.4aQ47gAQwiTgK1Uxejbr9iXknnWIdQJpWbwVY_wer0rYZNZ9boREakKpK3w5iIzdLgsNcs
 vIYF6cgpgIqTM5SjU69YRLzQkY5Zl_c0BtFT7f5bFhCxff4SmwE9lH728tj7qlOoRFTLSJAbsayF
 yQnaou6H2UU9kjbzl6vJLgj41YUrfMQJPKkutwQP8nxo949haOUL08aYpQbfvSSnLLmBtWImPLhd
 mfDBPulCYdb4K.1NAdQfP5pCjYcP3nQJNd2A3eAQ9dyeZsVxP_TWvw25ALPK539vG5PqE8Xc5UzO
 mV4rFJfbd08pryZBNtgcyGjj1bAbFmft2xEay2nBAV9SMZ6y3NfCsnR3tvZKRbOHYoErPGzkL.k0
 9dq4Iu_4FVrjjxa43Hu7pxD5Lovr2dQ6WV5cCQ2qUz7rpz_UaIHJt7AQ7eqWuFZA8tG.8p4eK4OD
 4uf522CyfiSwFAEJznVYZWveJP1E72twMF2Gw9AS.SwircMzR_Qv0MV0EQ5HAz_tHT70cyNp9.h5
 v4msUh3d25PY_TsZGhcA7u.jFNYxiM_WFseKMOqyDGdiiZ9r02TR.nOa_dkqpKSvCNbZNoFx8gzk
 FZSMahpA2prMN8DZTONvkNFk2ZMHWZbJrBS2dCvEmzTC97GAp.dW8a1B47ssI28MbCsug6rVZq_a
 LbUI92o582_bAuorsxQm29qKNCotUP0zFcU..H0Vqim3OyVNy1O4fFWmwqpZOzoqMKFdaEOlVBbm
 Djsa3IbvjtFJW9THoWfjV1o6s_TKZVgO4CEx1RKgCfZKF2sydZAhGTe8VXF1HtO0HG_t5tZ82pR7
 QpKY6lzXzfX3YhOSIwj1kjDoluyEFi_HbSdOWGAG5zXNLyhtalwJRmG4AZIvvG5WyQdrBUyA2wYJ
 KOUIyrdQggHXZL78COaYmYNvkrRum1lyjLY8nY9s1QxnT747NF913_Tz1pA9dsD8HjfVJR5fk9rw
 K8LokGBv7DyY5xBSxq0z2OJWF.TzYl5b3D6s3nANVmCeVH8YgSFM9SvOchgQGxNUNSI2U_YoH3e9
 px98hfvIG04Lx8FxGUmTBPpCcQ42O6SRC28Wz4Bsk4Mi8wa7etVSWocEzDPhgcDKX.RIdSnpFfL1
 wirw.TgudEN2pYgoEDc1tmGWMWO2hdTd4UFAdsGETYj_yo4qT3YsVkIMI4CkR3Mqo6pkvCK8xN0j
 wjtaPq.8tEteDM7fwjmS4ShZiAr4_NMGvH009NVquGzNtefhkAlvtftiy0WX9O.fHJ4JePrqJFW9
 NsYCDIQD7NxxJU26WrTNrmRqI32CJ7bhEnI4Ta7SNgD__5GtYR62N2Vq5Zy7qUGHro.lJPq8y7fv
 dDql.iV9G8xWFYvc0ldHzldUOGYhYi4R5Ef.ghiLv_hGAggpkzepaTUiNYr5HQtIQtzdqYswqN.t
 gsxzw85QTDeSBwzLkooPVduFPoHo1cNPjLX5owa_h.1pyDaWsf74aFfTWipeVfrCEuntdphLZ32o
 cIIro4Z1s9kcgYFHcPf0QHRcAElg.Zr2Vpxp3TRfk6_6MtLkFtsGCUV618RdfcKAmt8OR0sKtCZL
 YogK21I0qHXSNsdrqNv01qoPBdPu289jZ1k_oiCZcCTRIZ3_L0NBEVsUIGuBQbyadifq20XCKlaF
 uEkckMDwmCFZog6OFJMwLlwS7Ho6pR9sE7nCDT08PrKWRqrxz2OsV0A40Bp0kySC7w3sgaQMPHSS
 gP6tKsuFIq7IlckrssaKF4tD7M8SHACGn4A1MWGuln_H2sm9S4gyTxick1OEBSgJheuXVAmPmQtQ
 reTPcyc5qBlaLlXwyMuee._ahSfQRkHdXcJ_DXQRJTIXw2fnOHPh3ilTbRSzVNfWoxEHvympnUy0
 FYRuLYN7LvqFwGHVV2NjLYL5aifNHcC.c83HeDyW_VZCFdRj_CkNY_G2p2RZF9qaYJ51ZvoOvMQ6
 B2upWr1dX.Jr3Vm.n4PC.uMuIXg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 30 Dec 2020 08:47:45 +0000
Received: by smtp416.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 68e206c49d6e76b1b6872a88eb7f98ec; 
 Wed, 30 Dec 2020 08:47:40 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH v0 0/3] erofs-utils: support multiple block compression
Date: Wed, 30 Dec 2020 16:47:25 +0800
Message-Id: <20201230084728.813-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201230084728.813-1-hsiangkao.ref@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

Hi folks,

This is the first RFC patch of multiple block compression (including
erofsfuse) after I carefully think over the on-disk design to support
multiblock in-place decompression.

Compression ratio results (POC, lz4hc, lz4-1.9.3, not final result):
	1000000000		enwik9
		621211648	enwik9_4k.squashfs.img
	 557858816      	enwik9_4k.erofs.img
		556191744	enwik9_8k.squashfs.img
		502661120	enwik9_16k.squashfs.img
	 500723712		enwik9_8k.erofs.img
		458784768	enwik9_32k.squashfs.img
	 453971968		enwik9_16k.erofs.img
		422318080	enwik9_64k.squashfs.img
	 416686080		enwik9_32k.erofs.img
		398204928	enwik9_128k.squashfs.img
	 395276288		enwik9_64k.erofs.img

TODO:
	- support compact indexes for multiple block compression **;
	- support multithread compression (keep compressed data in memory);
	- carefully design kernel optimized paths to maximize runtime performance;
	- widely testing.

If you think that'd be useful for your products and you also have interest
in development, feel free to follow that as well since I don't have abundant
free time so the progress might be somewhat slow (I tend to finish them all before
the next LTS).

Thanks,
Gao Xiang

Gao Xiang (3):
  erofs-utils: add -C# for the maximum size of pclusters
  erofs-utils: mkfs: support multiple block compression
  erofs-utils: fuse: support multiple block compression

 include/erofs/config.h   |  2 ++
 include/erofs/internal.h |  1 +
 include/erofs_fs.h       | 19 ++++++++---
 lib/compress.c           | 70 ++++++++++++++++++++++++--------------
 lib/config.c             |  1 +
 lib/data.c               |  4 +--
 lib/zmap.c               | 72 ++++++++++++++++++++++++++++++++++++----
 mkfs/main.c              | 14 +++++++-
 8 files changed, 146 insertions(+), 37 deletions(-)

-- 
2.24.0

