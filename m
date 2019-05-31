Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E29305EB
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:43 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQrD5kqFzDqTL
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263900;
	bh=yTcrqc+OwPV7uyvQhUTboF34wcamo1y9oepfrY4imhc=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=bN7naFXi0cFbLY3BG5ylnGXRXq+Ap3Xdj9SBgB3M68QoCS5C1OGL4GCPBFQJVsd/E
	 t2EpoU86djczSMXv3TLlDT4LLZQahNYzdaAFipaDYd86WsHXEXo4lk2Ykg5cC153Em
	 eNPm3RqUnL1lQlGVpgk4KWmZpHyC8pNOOelKx4Y9rUW3pjq4UuJ8zQBnFFwvFtUsWJ
	 U4fsJB5yPACN6vNt23Y+gZJ+UcIh7836Ktdl8AUzgEhhBrnpNWvgiNP3ibNlhc2rR3
	 f1pO6nM2gwpleBzvUTXAAdGmbHGXIIUUNdo9t3gj09JqRkjqVRX6Bfz1C7dwmlWNny
	 W2u0X+uJNsWfA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.206; helo=sonic303-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="Z3HunVHu"; 
 dkim-atps=neutral
Received: from sonic303-25.consmr.mail.gq1.yahoo.com
 (sonic303-25.consmr.mail.gq1.yahoo.com [98.137.64.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQql3FrkzDqSt
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263866; bh=uf1YN6iE0ydjSsMH5WUPUG7lIhwHWlHUKUv2UWiK0Vk=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=Z3HunVHuRbSOc72DVkjVnqet8m3l5QqrI73SpoXxaMDsQjbn23gHsFPc0Io8iVq6JlTgw9x54O+4ZAvGvQA/+stgTW6z3kmivvgtjpj4ECZyZlvXiGrpb+DoXkMdlGoOkG/IOQIwO9oR8BI7EKkhGyH1kB7H5AnvFWID1ZuqcytpYbyIkQMesHtEE9ZjJ1rf+lZlkhV7soSCBqhfx1PqHt1GNNzPUFA8oZSslcqj1nnNpM+Tecurycon68Q9SCnc4cfdIlLAJUibvDoop3YdwMhrWIh3JjA24NhNEk4cLmif6HqLfxLhK0nKkxbr2KO99bqIO9MBRBOMwbDJJ0dDPg==
X-YMail-OSG: tDGtqPkVM1klho7ZXL3qWxIIf9oJ.x0oeAVMIlt1vhKvFxPrRux8S_YBqZPhItj
 v0KGm0mqpE2Whu6KtKG3WSiVH6Noin3KF1dmx9GuWFKQBZvIbt3N6uu2EOqzbMNkLpm1P8bE6QWi
 pBVv_9Iqi97kWnlytTILIvZkiEisMqEpdzhp174PudNxw1m7IxNln3dKRoFBKbMLhV.1hups8PQh
 I.07n1ui5vkE1UL1xDdZbQvPxoMl7Yh6tLg2afaP_LIjwehHnb6Z1HBDsQk.o_EGW8uFPqfctx0P
 h4ZA58c4.xd4LGTbGCv.vDcFKuSEnEkXklRlUBl.Tkq4tGdlhfQ3tDRVJohQDnkqgKicYLlVoczf
 jeGMeYikXMrok9CetcDtkIh2R6zozoc5sLL_G86UGhI.ktX4HawQp2FlL2TQ47dp9xb9pgl.QTX.
 vgeu70Xsf8lRPnU2j4RZEHvmtKBzwqQydj2agV6Yi0pIp49VAMklyIyjqvrMEg3RMfTuUF.RrC10
 fON4PrPb7X_0DJuWZPFpY54CQD_Pq5PgawVMsZk2mJhGH1Njd84R8bqPL2mVzGiXSzDTTcFpwwc4
 zMSv_PW5cVLo02aAxuWrwyC0lpSBZW0kSnTdRSrpxvfFFapYSqYGIABEM.aWkscm6mmq7UqATtUS
 npYSr7SrPW1iT3HlViy7fR_Cgg.OMqZdi4_t2P0LAH6MUf6S5sG0c5k0mAAgT1xUREaWx.lQFByt
 EJ5WHBHhR8Wn6JDTv5FToUTV1GSSw.ZPM8fKffLDSjOkgF9LZjmws1i9UQIp9LDkGavanwGA6wgW
 Y0q_Su7ljJq_CoVIUtSqd5wqUJ_FLmQYrEsrc0Q0n3CavFUxhRWLyRg_3xxP81AjVxOYoi2m1voV
 3fhdx5qr9izv2IUc97tIZn3fY2SJkxuXIpp0qzikSyDbpGgz0jr1J79Vy7ulYE6OR.pqc86UtmLx
 L5JqyuWJJU1hZ204NTddwTwsYSgM3km1lLVE9QXUwkoTgFE1ENNNbZGY.4DLcQGAxqIQKq4bK6S3
 CHiTWt_sbrNQw5Ig8.AQvMg.y6czVBz0lrYClpu6Bvp3m6CIKmpCWX2p2fzr8pOJE_kgypvwEDmE
 6GPEcvkv0w9Hp9CMBuKYLF_jrLJD3kr2vchGq84GfUYaY5cOtJyF7bJAMuksokF1PfINrLuaB96z
 0wD7XfJrlF.olkSeNOTDHpAmUweqIXj_R4gNgOAIVahE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:06 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:01 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 00/13] erofs_utils: new mkfs framework
Date: Fri, 31 May 2019 08:50:34 +0800
Message-Id: <20190531005047.22093-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
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

Hi all,
I spent nearly a month to make big changes to erofs-mkfs,
which mainly introduces a new mkfs framework.

I personally think it is much cleaner and more scalable than
the old one, which is hack and not clean enough.

In-place compression is still work-in-progress, thus it isn't
included in this series.

Comments are welcome!

Thanks,
Gao Xiang

Gao Xiang (8):
  erofs-utils: introduce buffer cache
  erofs-utils: introduce inode operations
  erofs-utils: introduce generic compression framework
  erofs-utils: introduce lz4/lz4hc compression algorithm
  erofs-utils: introduce compression for regular files
  erofs-utils: propagate compressed size to its callers
  erofs-utils: add a README
  erofs-utils: fix potential erofs_bh_balloon failure

Li Guifu (5):
  erofs-utils: add erofs on-disk layout
  erofs-utils: introduce erofs-utils basic headers
  erofs-utils: introduce miscellaneous files
  erofs-utils: add input/output functions
  erofs-utils: introduce mkfs support

-- 
2.17.1

