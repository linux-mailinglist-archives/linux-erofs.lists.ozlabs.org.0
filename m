Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F42BC1F6
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 21:11:46 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cdl1W4bT2zDqjX
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 07:11:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605989503;
	bh=OLEwYPrSZv43PfuPC0L6hbXmIppg9l+0++IV92TqL5Q=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=MfPcNdx0K3/cSqgl9VE4rhUI+coZTTpShsX4nfB2MJAqrzyLKXmkesOdliFhnJc6X
	 kP5wDLCCUzcYCQVGXSnauFsI0AY8lqnjIVhen+GXddAn4jqu/Y8p7P6RrARySaL89u
	 AhkRJqr7tHGVfVJUWtNPHPFHViIPAp1vbFEZO+BImO5KpZ4L3YWCZ2XJjA0YYjOoik
	 1budXRJrj/0Z1oVeqtwcJfMDJ+D6QoGez44a5BejZgKExJdeRl4cxG62dnMTP0qt7v
	 3Xrsq3XPWcWH7LUqeYKf9J6iIjchxVMNHhnECPksEyz7qDNDMJPOVtdRTHvYqntd26
	 uUo/U7aQAQYCg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.31; helo=sonic308-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic308-55.consmr.mail.gq1.yahoo.com
 (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cdl0v6FLqzDqZN
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 07:11:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605989463; bh=crC2MQB3IBUkm0fGSCpDODzvoEI/9AWOeoPxhbtWSDk=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=lM4wG3JA/ou4aBnazwZ3rHiDc7HX0n2qN7A3NLTh8hDu0i5v56Jb+JQaHv4X14eFzbJ8BdQvcxvLkgQZO7PSywkV3Kcb9xzBo6L6WGQ6Yf7eUv8xjyoIp/MCuAEvlXjEaLkBii/OON2j6NV8FGnnBKBCmfiagJ8i9Qapobyo6WHjxCXvdInRWoJJcQD0uMfNP2NoJoHcQmo7nAoHxcdvKYvwYN9GZHU9Cak8+EOBj3EE9t7/dO9Uhdj1R/rCiKBYwVkAGewK78MLsnsxBrtVwxdAtLHW03Tya15RyCmrk12YaZnsCoW82aZWBViT2LOI9OOBzB2q2ZnaOSd+MaAfBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605989463; bh=VMEhxcWgS4D4tOQzCHBLQqbCNXfWl5SlBkXWkLyJq4p=;
 h=From:To:Subject:Date:From:Subject;
 b=OwgWPiRYic9QjDh83zIHUb9OcXutxQc/k2h0/MLM6MqynAEhPNbWgI7ymlI9bioSo9nFBz8PXhtiyPdmtcZdaCU4Xad9bHg05pomkEE2KJ32sonANmG7aG18Z8Kw1LWZNbIbg/rui/rUurPC6dKZ+4kwR/gsfnTpgQ7avzZdt4ni1inyY15XGpFlWZl5gC1wJnxcSIRU3eGrpiS53a79WaLSblM6pp1TqRsIZPmAScsEXi23PqBqDpL0FhBcKsP6LB3zRhb6Ixv88fHTxQdG9PAST/+8FCGsmzfV3k07ofep1u5j0yP+oIxmVApYeQOHOrMQ+lgobkuuxubEAf8Vdg==
X-YMail-OSG: xTfBcuQVM1mYqbnPQTAyR2bH_9S_VOOXEsIkKola0qQLVaQ0ZhU.LxAY3AzropW
 fluEKPmyHqwVROUUSL5kufnoKlrVgmqlUf7zt9Qqg8yTAVz1.LLUhr9YzS3SDgNlv6N9oFQPmn17
 hS6M93nqQarrxdV0QTcnwSXySsPADmvW1b8aq2jbPGFWEj.BzYgO_qIugA5YLX7FmhAhL_UJ1l_n
 _nOiPQA.2JMaIQ4fUofBqAyIDjKbW9Ked2y3Gp.jwfIRjBvK0.R9bXFKyPaBnuODlRM7fJ_2PK0u
 uce_WOThO5gCeheyoDiD7jMIlG4aMDDhEA4B1nnQkNyCNJMOgGkahuzHpKNsQVujeAcJwOMS6SGz
 3aaOIlLoXSQCsvjmw1BbjoSQo_s2d56G3_il0aJceCf7DFy4QBKCwXOkmKGBjShK3PlbGKthEvpC
 ab8zlfPCaBnX8DYCxE1ocdZtdL4QzAZnBNhtDaOe8k1WeXVuSuNYsgl55Q3mev1WdIUKt1ZOo3UU
 vYgotiqAuSkQWVG5iBWBvs5tWF3ur_EiZOgZTwcDf9NJ0gLxYWAyZq3gyrtq0aLQcT6_8xiOBUQY
 M9fLYFBomAx.7fHJ9C9C02V0SblnoHmuiM67DkgD6pc4tCS8bUzTdjPOdyNeYuig9v.HItXuhbJf
 df9AgKOdE2wBNFiYQYLOehv6C837Rk2UTARTWtL0FqYuaN_e4s_GiVTAzUoGeb1Wwyw6tICFfCO.
 _iCkI8q7490sMWAlP09UsjSj6l1hk2KvghBqSSy7wvi.zPLAqKByNndtDbm5cfalKmVYQDx6UYbv
 3W_sn0HCm5QLO_nb2jQScEJDU73oDYlGFHKtQ8n.SJcp8USi.g4Cp_HPbJT8cfANgQi1ZF0crr0q
 Q8AAt1v3uP0ucuBCt5SHsuviEkgfLAFesfNx2TEjnc8AojpPr5SKB_spxulpHpqZOKvyLbVQT9Eb
 8SqVgs6w5ZteEmBb0vovizBKigqX6R3Hr6_AcIseR6sP.8gwhjSLOtB__kiadDVsoVPw1MDRZwFX
 rTK9LGGn1styZqP_bfT8vt092jGlLFZxXvZpKxIJWE_plzS8Ivdzdh9P.J4fSg47SHnT6mCTpgDF
 REkZ_dg3U11hKoJBI5MjhRG.EhrK3D7Sdr09ur_NfhTLOAxDlzhCF0c9TLqy.7.uO9ZL50HFwjHr
 MsjGStOsyTEV.5sMCCyMvgT5Hfd7vO2a7OCd8NNUAW.1wZ46uC.zQwdAFMK4cP4.xdhI6bgWgO.i
 Nxln_AYVc96xLraWvVWtvmgjsMY9.otxbza6bghz8BQpvVUo2SgYnigRFtxycTApLa9yuy5EPJrN
 cmEcsy8iTjD09FNV_HAaSgmsTDskYXfKH0eUSvACzgbEkWbeVhu79dQAMiNJPyWFlEViRGHCiq14
 yI2rXZpf5ULIc9HoqytcORajg9C24485k1Z58jyprDI4nHfRSTpWdToTyw2TgDrqkjGYQCgSXcxJ
 wEZuKTj5ZebcWD2dCuNB0brMU1b6wuZm8RjcsDtulawPetuOJtH8q9MieB65lGWBns3Bghgejle_
 wCrtOJ.g5bp7ZefVXompPGW..NyC8L1iZ0UbbPqrONrfCx9ocr9whPx5KGbFdnnHIE.RLXDnfuLI
 wCYWij7kIn8fmJDmW0PnitngphZxdDxlfa6sNwAuXz.PWmMJX84J1FPzmcsnlWcjbdNpBINngONc
 eTPw0CDKA8o519Yx1iEw9BPian2ccTpP4lhj1eBJGAGvoNGLopvx7OWZ.Ov6sVtYuRLrd8.oUaFw
 S3ZcNGMxlluTb.a_eSgvw.9RywQZO3CDXLYDRSgOqvb6Oije_mVwJ0K4G2yT93J4HlxT0TMh_qNS
 _qNFdkoGckZYMeoW9p96aUiweKVyrqGwiVF038nDOxXz.w6Gc7PtPXABrIvhz5g0x_UnNINPFC3z
 aoPWxvfsu5fzqlZadlrceRBYnFlsum0fcVTtEZfyhWZTVlFX1.Xzatw0VrbW6i339u.Q4c7oprM3
 wbt0AFfTNoxJOZgrLfEgmTQV.Gxt.rS9Ma3NRqkOFAcWNSXd4GC.HZPv9PotTeKn3wieq_DEFEDl
 RhvfjiJNysFAs4ZTqLmmnbENaFAwXPUHMc90miF079lRj3RXaC_a2i5LSgF4jftobHcNIc8jAuv9
 Gjp8EGM4UhYjHGUDpQBEeZO0iYx.t.ZEzST2bi8W1Nu73_v5ffdSMlkLZdfJCMs9Sn9VJSgGc8ov
 STlTAsnjaFUYyNSwzaWb1AIqEc0UktM.nJTmnWF3dfz.uNiymQdzYODEfVFmFHpE_P6tvPX2INX.
 mciRAk92ACCIu17qYiiVmVckAnIWugDj.iJDpCxBXKMx5FrvDTKUE7FPyYUNnACU_7ILbcakvKIb
 r8ZhPjO1ndRjOjD7uxc9TEeeUQH74V6vJYG9b.BcGhiIX2jnDlt.37VvLhhy3NBqv0fUZLTaak2T
 va5AtufUkWNe7bDx5cSs7apYaTNm4JsuzYDk.9XuWoTQsjoBHBwQqZy6rYqhUO7.K3KriHp3KEe2
 OTpXA7DoMrTWqUv4eP419gTe0NUm0pqKR7ie7AMM6B1XNIa5T.nrWzE2jguzQS3Hsxl.AoiC3D6.
 GMINfJD5ckyoeU55oynOyag6h7_Ty4A7uk2E9KIZshszBO8c4C9vIHOvRBk7RzfyW.PchF1NPDBr
 0RNDFqRpxKjDsfEnIdeaaOZKf8VpTbGb06Tq4YqIVQ0GKhu9OGqTx29hIaAr7AUO3S6hX6_9RyG8
 IUqRQ28lFlq6VOST0G5d0GNTDfG9tJ.QbWMvNDorSHiA.kVBoCvnwaRSMWJR2_qpMQFm7Fx_eizi
 ifiwDcndtvJ2WYRDfNoIIPzSoXXqTsUHenNyqTGrahsZgQGHXJPrGaeCT6dfIfnGaWIGIaY1Aeww
 eN_UDLyRjz49um_4d87c-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 Nov 2020 20:11:03 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 6070243ff164391bfc53a248c45d6337; 
 Sat, 21 Nov 2020 20:10:55 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/3] erofs-utils: introduce fuse implementation
Date: Sun, 22 Nov 2020 04:10:07 +0800
Message-Id: <20201121201010.24724-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201121201010.24724-1-hsiangkao.ref@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

changes since v1:
 - fix off-by-one error of namebuf in erofs_fill_dentries();
 - drop unused "struct erofs_super_block super;" in lib/super.c; 
 - fix clang/32-bit build errors founded by travis CI.

Hi all,

I've finished cleaning up erofsfuse - a fuse implementation of erofs
just now. It's now considered as multithread safe since it's
currently stateless by killing useless caches and using high-level
libfuse APIs(also libfuse itself is MT-safe). Therefore, I don't
need to release another liberofs MT-safe version for now as well.

As I said eariler, the main usage of erofsfuse is to support handling
erofs images on older kernels without kernel modification, which
was requested by real vendors (thanks to folks from OPPO to pick
it up).

And to summarize the benefits of erofsfuse, I think it would be:

 - erofs images can be supported on various platforms;
 - an independent unpack tool can be developed based on this;
 - new on-disk feature can be iterated, verified effectively.

erofsfuse will be included in the upcoming erofs-utils v1.2, but
disabled by default for now. Since it still needs sometime to
stablize and also notice LZ4_decompress_safe_partial() was broken
in lz4-1.9.2, which just fixed in lz4-1.9.3 days ago [1].

BTW, recently some other people get in touch with me in private
to ask for some latest micro-benchmark among compression fses,
so I spared some extra time on this as well, see:
https://github.com/erofs/erofs-openbenchmark/wiki/linux_5.10_rc4-compression-FSes-benchmark
I might test on hikey960 board as well yet need to seek more
extra time but I think no much difference on relative
relationship (but yeah, CPU-storage combination is vital for
seqread uplimit).

Thanks,
Gao Xiang

[1] https://github.com/lz4/lz4/issues/783

Cc: Li Guifu <blucerlee@gmail.com>
Cc: Huang Jianan <huangjianan@oppo.com>
Cc: Guo Weichao <guoweichao@oppo.com>

Huang Jianan (2):
  erofs-utils: fuse: support symlink & special inode
  erofs-utils: fuse: add compressed file support

Li Guifu (1):
  erofs-utils: introduce fuse implementation

 Makefile.am                |   4 +
 configure.ac               |  22 +-
 fuse/Makefile.am           |  10 +
 fuse/dir.c                 | 103 +++++++++
 fuse/main.c                | 240 +++++++++++++++++++++
 include/erofs/decompress.h |  35 ++++
 include/erofs/defs.h       |   5 +
 include/erofs/internal.h   |  94 ++++++++-
 include/erofs/io.h         |   1 +
 include/erofs/trace.h      |  14 ++
 include/erofs_fs.h         |   4 +
 lib/Makefile.am            |   4 +-
 lib/data.c                 | 204 ++++++++++++++++++
 lib/decompress.c           |  87 ++++++++
 lib/io.c                   |  16 ++
 lib/namei.c                | 264 +++++++++++++++++++++++
 lib/super.c                |  78 +++++++
 lib/zmap.c                 | 415 +++++++++++++++++++++++++++++++++++++
 18 files changed, 1596 insertions(+), 4 deletions(-)
 create mode 100644 fuse/Makefile.am
 create mode 100644 fuse/dir.c
 create mode 100644 fuse/main.c
 create mode 100644 include/erofs/decompress.h
 create mode 100644 include/erofs/trace.h
 create mode 100644 lib/data.c
 create mode 100644 lib/decompress.c
 create mode 100644 lib/namei.c
 create mode 100644 lib/super.c
 create mode 100644 lib/zmap.c

-- 
2.24.0

