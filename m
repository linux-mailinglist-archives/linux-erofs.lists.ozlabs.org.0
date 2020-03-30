Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B99B197299
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2020 04:39:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48rGr73w7lzDqLd
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2020 13:39:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1585535959;
	bh=VJrZVTAbvW++YLVdua1XwHjl1sWEymPpBgvh4sU6uDw=;
	h=Date:To:Subject:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=l/BQs1SZWSw04gUfEhkzEg7sAGhqNDpiOaKf8ddXdYyZk7w+XpMkwdJh+tgxeGXmk
	 Td3nih7Yf2j6Ymt5F0PnGwWtBZFdSqGPcgQZWXVuXET1HCfeMbYvSbnnGasJwyiBbc
	 87k4TeEiLaIRMeLmDAh8UlDZ9TIsrQ23o0erAlcWbjXJI6kkgix4cRkGvMF9F1FmQ/
	 sfKxy36KZg5Z5uApda9SBROxdDFgLwwAypw6o4m+jTGc41uL7PUL+iNLi84jGxn7zA
	 SyrMThdtafBz7dqNfuCSUlCICZXvRLcrAcEAj3gvRtQSFFs1+jl9q/beQTUQq/Tlnu
	 Q9AFTdXYNmQjg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=66.163.185.33; helo=sonic313-10.consmr.mail.ne1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=BDgnOAJJ; dkim-atps=neutral
Received: from sonic313-10.consmr.mail.ne1.yahoo.com
 (sonic313-10.consmr.mail.ne1.yahoo.com [66.163.185.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48rGqp0rhhzDqC9
 for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2020 13:38:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1585535936; bh=VD70aeVEGZzqHFz6t1O4xsHegNnmsjzLe99VqM0PnYI=;
 h=Date:From:To:Cc:Subject:References:From:Subject;
 b=BDgnOAJJyyQN7W8Xtn6o2PGR2Cg3SdTScuhUnYY0WCmRW34yj8rNvJHL5GuA0hBXjJPkq97yaHmaUX6wEp1kthAKjJAST/QwiRXDFnSKrKaFscScaJZbS38utwyLC7+Km/ywHT3vnsAehFOYNvoo7tMuIYBNatN/k3/4Ly2sKLEGgIOrdUXI2OO6DdBbSKg6/D69B9vqbtfpyNxQj27u/MwYkdQLCVZtZEaQagiNWruA6TCG2gT4s0AEEE0pAGoODAH53zxje0JDJnY41payd04igsNHDEDzsLZHTfvqGY4XyerVzLJFIpGaiF+jzb7yJVqDCke3ZWUJaYzhIY5uIQ==
X-YMail-OSG: xTFBxcYVM1mbjayfIp4dm6zffI88jjoYlXxO_oLCjEPmgAYfjgh93gq6FdR9Ay7
 3a1vldahmOpihGMhB8iQmnQxwf6Jws5Y9MFDvLizxjTEyIt.DhZlzJr03LG_Aqdt.bY9LB_rGRYy
 kT30W.CMgKtgs8mspVPTunTTIc8YEuIqTQ3QfWH3gdU093vWrlGIK26lkNX65eebwcycAJAs4Eu_
 CLwC6gVLcqYP0YhjeBzsR.XCGnb6JsEUTQTzxc4g8yCCjohSz0U0fVh7jVmJN7C4EaTy7uiI3yJs
 w8wHOd7cG94bd1J2mif1fv6zRcmbf0E2CYHKACjNSf7KdrtVlQ41s90ynMHohzkQ4_qMx6Xngc5p
 HeqfwSuFvqIbA6.HZaYX4HIjVY1qEQCE3gbiv6AvMFgkfVLy.0kUsc_scv6oYnsBEl.vKnuTBwlB
 20dboLrgGRjLcNOe1FYEtXAbjxaeFtuERhs6zn2wiiAq8wzU1Dh15Wslv9UDNKGpR7z9vQCBRmJD
 TVpZ3EqOjdHyT..t8_y8782G7C18ykbxUH0FLfy1Q0.Vhq7c_RSsyU_mDPEceXePTmJ0iBfjojsu
 6wl9EPHbcHUENqzGeK0y6xm13gAtR92GQ.C1h9NJdZyqjajHrkH0Odb0MnLuVnEBX8bhl0z7uanY
 b.F.Xx4BtyxeK9n6LUqWIIJxJnlJ28SLsI.OoJD9765zGse8ClzA5vV9BJd5FXguQwPrjipzhdKo
 tzZnQzfydLdnr5JcZCtN.j8L_5wzaKMmmGNFbYWO0vvuNfaS6.7Os9SqWwWUw3fUHx3sHhdgGno2
 TQRtMzDxdWQSI5g4vD3kzBHmMzA5mQZ3fgueZmMczw3g.OP8WtVvoeMWDVYUpDJz7a0zJSJmqpRi
 QDTlZsh0KbaJ7ez.YN3nKTlC7tiLLKOYMnzRgopw.ljvXQuGcYDh02xbbIBp.7mJUSV.mGYmxWEQ
 4.9CH45rieqwHfoFOItsMGRUe4QYhmycbzG8Y4AZv0hFv_elUTcdgPrsbenZ1_FFjJJhafpeWF7J
 I2RKxiMqg5GQ9Hr.Ifpd1NoFXAv13JxP1GJVHh5Z0VHclcPBmg6VJBrjhE6WlsgZGeycPf3eIA.t
 pOSZL.J77wGARq8Z9Q2L5wv7lyBicWcEv_LIUdvz45N01MQjWE1GmMt.8Qjca.vC9o.G56kbXSg7
 KeX_wgZDOm4G7m6p6bAro0WiRMKczNjTH4WZXx7pIFT6UYGfc8JWTfljCIOtDgeFUV.8uGkn.zZ0
 WPPkcRfiXFq6ft36aGY4jAd6rXjyzh3zsexw3h6aXD6SJ9C4WfUvCxc.62lJUUjx7uZXFSG6GWpI
 9WCWOLh.zogHV8fahiNXPAlzdh.gFy7Ixjv7v1h9YFXCnEFJrONSjBbT6tDizNubevEDvLMH3.T0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 30 Mar 2020 02:38:56 +0000
Received: by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 0ff86b82b40f8556fdf33f02e5fb3ea4; 
 Mon, 30 Mar 2020 02:38:51 +0000 (UTC)
Date: Mon, 30 Mar 2020 10:38:40 +0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] erofs updates for 5.7-rc1
Message-ID: <20200330023830.GA5112@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20200330023830.GA5112.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.15555 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_242)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Linus,

Could you consider this pull request for 5.7-rc1?

Another maintaining updates with a XArray adaptation, several fixes
for shrinker and corrupted images are ready for this cycle.

All commits have been stress tested with no noticeable smoke out and
have been in linux-next as well. This merges cleanly with master.

Thanks,
Gao Xiang

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.7-rc1

for you to fetch changes up to 20741a6e146cab59745c7f25abf49d891a83f8e9:

  MAINTAINERS: erofs: update my email address (2020-03-28 14:12:33 +0800)

----------------------------------------------------------------
Changes since last update:

 - Convert radix tree usage to XArray;

 - Fix shrink scan count on multiple filesystem instances;

 - Better handling for specific corrupted images;

 - Update my email address in MAINTAINERS.

----------------------------------------------------------------
Gao Xiang (5):
      erofs: convert workstn to XArray
      erofs: correct the remaining shrink objects
      erofs: use LZ4_decompress_safe() for full decoding
      erofs: handle corrupted images whose decompressed size less than it'd be
      MAINTAINERS: erofs: update my email address

 MAINTAINERS             |  2 +-
 fs/erofs/decompressor.c | 22 ++++++++----
 fs/erofs/internal.h     |  8 ++---
 fs/erofs/super.c        |  2 +-
 fs/erofs/utils.c        | 90 ++++++++++++++++++-------------------------------
 fs/erofs/zdata.c        | 76 +++++++++++++++++++++--------------------
 6 files changed, 94 insertions(+), 106 deletions(-)

