Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9C89A879
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 04:35:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712370938;
	bh=8mVW/ekjQr33/sjQ6CxwStHJHhIljSFhy4fNln9/wuI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=JRv9ZNayGBgN0x3g2d0qtzu04m4bHhIfpbt0L/SCLMnbdE7mwa/6WiUDT3TzmGVNx
	 z2XFhzHLpr7E7tSKVnaQg5/40idTLfXn5zBtBCHwZXT1ngANkHv4VfxcVODzf8r4Tg
	 OCzCm0LfE/ORrvVIi5ADhG6r4r7KYKq2m8yahLkXo3iDLjTRiu6iU1YUo8si04QXm6
	 g6wXLSEMPcHT7+mucpG34+Cp+QkoQNCFasUFfQvVU+45/Wgfdw9Kfjgo3fPd27O2o1
	 JwJ7woIKzmjxY2X3lgWoCa9RZboey06iDY1csgp8j4ae2elCs+Cu1yZqYPILoZS2I2
	 oY67GAhDCDDsQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VBKGL2WDGz3vYs
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Apr 2024 13:35:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nyI0381+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.202; helo=out203-205-221-202.mail.qq.com; envelope-from=1156140554@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1829 seconds by postgrey-1.37 at boromir; Sat, 06 Apr 2024 13:35:30 AEDT
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4VBKGB4P3Jz3cZK
	for <linux-erofs@lists.ozlabs.org>; Sat,  6 Apr 2024 13:35:25 +1100 (AEDT)
X-QQ-FEAT: Xqh9UYnCrXDr993iO2PrFyhz8aSgZ8rQ
X-QQ-SSF: 0000000000000080000000000000
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-XMAILINFO: MJDh6FyLHdqf14K+5x9wIHKMQvwZAPaHA7lGJkNrSDJdMfA+I+fvAtjsoivW38
	 KiIRMmnOz4kPP3CObxjn+EYw/reXQYMt7kzdsWqesbZLNmc++PwxjlPzEt7caHezhuCcgWn6D4jsl
	 10zuNhYHjLafftCZX4zC6GcrLqTWejfpe/3EfE0cfrdExIkiIb/BSsdZzonIi+pARIQYjjHHWiHMN
	 S/XJgXmMVDvUzV4ZJJsj1sGa0eMr6I+GE0SCjiSrKZuoEYrg2a1QfR9Zo23vuH9ZvQPOsq+piRFR0
	 grr3+7nxiRMlMHG26jxAI8aYNnsaFeNDou0TPVgPArNy2RHsgxsDTiQpQn7YWfq2Zh3PekMWswUZW
	 Q3jhI9cJ+0g958VLPw2IqhPjXhOWLOkVQsP7p8mpoRan0i5nrRpo2gA0Yu965YrwTdZ1mbMvkil6x
	 FA04sz0JaH/4wvVLQaCbe9tsmYt2grdfd1lsWVcPB7S+iNQQd/2puvZYlJ9H+2rdqaPLN+CudFABC
	 4riWR1q9lVcC7a2RA3FP9KYQxp5S/tXbkIrzd6v1qRbJfJeXhjHZJXs12Z5ew5u+iuie7oCGfrCC6
	 OIe2f3/x6jDMaCNzqcHdGm1xOW6cCiY2hkPuPyntmd7fUenFP1BM8J6Apu0pzgOkjg1NGPNj4aoHA
	 7gWvJ9MpKEpp8fcH+fBP/c1xzXF+1dNShEarcwYkCniTdYsbD1W7kxeIL08D9GkstBrsrwH/3gfcj
	 YPn7/kmldoelLtXHoGmt45oimoH8q30WzYndIZllC0WeEQAClr9R5FGqQQs3Uu0LEk63b7wKALrfd
	 laBVAmSuimAR6vLcXFCkgoY3KMhSlx3LEv3saDWniFsW6gL5ROhTFMDNWyWg4BTQT8+yq5DGeVdgB
	 uCPh2lbSmssca6ECJSluF0MqpvlV6TQLkpxoBPJEtZAyqHurEhx/EqmL8gC5VpLkC6NNzPM1kgruf
	 vBdAMKTuXOVDkWf2AQ
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.12.157.17
X-QQ-STYLE: 
X-QQ-mid: webmail268t1712369021t4021500
To: "=?gb18030?B?bGludXgtZXJvZnM=?=" <linux-erofs@lists.ozlabs.org>
Subject: =?gb18030?B?xPq6w6OsztLU2jIwMjTE6r+0tb3By8nnx/i1xL+q?=
 =?gb18030?B?1LTP7sS/?=
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_6610AD7D_139A1AB8_7CD8C1ED"
Content-Transfer-Encoding: 8Bit
Date: Sat, 6 Apr 2024 10:03:41 +0800
X-Priority: 3
Message-ID: <tencent_75345952C247D3E1F26BC00629354C648A08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
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
From: =?utf-8?b?5a2f56Wl5a6HIHZpYSBMaW51eC1lcm9mcw==?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?gb18030?B?w8/P6dPu?= <1156140554@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a multi-part message in MIME format.

------=_NextPart_6610AD7D_139A1AB8_7CD8C1ED
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

xPq6w6OsuNDQu8T6sNnDptau1tDUxLbB1eK33dPKvP4NCs7Sz+vXydGvz8LJ58f409DDu9PQ
UVHIurvy1d9WWMi60b2jrM7SttTV4rj2z+7Ev7rcuNDQy8iko6zP68rU18XX9rXjubHP16Gj
DQrXo7rD

------=_NextPart_6610AD7D_139A1AB8_7CD8C1ED
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj7E+rrDo6y40NC7xPqw2cOm1q7W0NTEtsHV4rfd08q8/jwv
ZGl2PjxkaXY+ztLP69fJ0a/Pwsnnx/jT0MO709BRUci6u/LV31ZYyLrRvaOsztK21NXiuPbP
7sS/uty40NDLyKSjrM/rytTXxdf2teO5sc/XoaM8L2Rpdj48ZGl2PtejusM8L2Rpdj4=

------=_NextPart_6610AD7D_139A1AB8_7CD8C1ED--

