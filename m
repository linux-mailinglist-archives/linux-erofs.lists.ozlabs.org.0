Return-Path: <linux-erofs+bounces-1016-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808EDB51E6A
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 18:59:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMRjx08fRz3dJM;
	Thu, 11 Sep 2025 02:59:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=179.61.221.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757523556;
	cv=none; b=ANT4Tk7DeHV6yDI6wV2t8R/31dPM3Ma9R+YIT3/cXh3RnWoJUWuIcVPwnhN+dWyRB3r9QZ+jiLchhipPGS40bX9B36wxiALOgCpz3Tj+3S9XGPvH+ihwKf1tjVw2sSehpkSjgvqUu+ewHSo2yQ2r2rd3KAh2unR8qYzjJ2GL9/u7Emt4q0Rrhw4iXH8OPutg6XJjaPIPinqgmPXGx908uaMxcFbqAiy3+bBPPs3FqdA0HPNg2vmoMdiixo7Xkqvfaowp3fqkjt08YXhIB3SuZNvScDi9qrwplZndUJ2bTyThNHAVyIu56ZLsEtu8fikG66Id10PKUY45EbAncV6c5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757523556; c=relaxed/relaxed;
	bh=GrRrNTBmtAg3NKzjCEDPNODlg6dNaZnbmOpgy8NOndI=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=Ur2f/S46LTFz351iYAg/bWyxEWGtEtOgX4kxrYIocHUU4BRriM644w15N/2CVRaPbe18avH/jSHEGG9lFFfVkzlqkeAsBOdLFlfnFdhwb9X9i4y+8knpqWEK5G3ZudB8c/CkxCIm4T6CaolfsrMrDL4bsa+Qr3WQYNBGqQ7bcR9TypmvC9Bs1XagZOIa3fsO1886duUfnHQeWVtKU5sFGuJ4tO2gSzP3WHdOXnz/9bufJZVXAEVL2I06TR76Pn/WU5Bb4EQimUBmklWkJjOO0dMhcryaqVysaZbYdH6GxweuXDsCnoO1wMvqmgU97Ahh/wKiO1yKIuabXANGdvIEiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdczsk.com; dkim=pass (4096-bit key; unprotected) header.d=cdczsk.com header.i=@cdczsk.com header.a=rsa-sha256 header.s=default header.b=p8nwOd+H; dkim-atps=neutral; spf=pass (client-ip=179.61.221.56; helo=ile.mangn.com; envelope-from=department@cdczsk.com; receiver=lists.ozlabs.org) smtp.mailfrom=cdczsk.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdczsk.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=cdczsk.com header.i=@cdczsk.com header.a=rsa-sha256 header.s=default header.b=p8nwOd+H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdczsk.com (client-ip=179.61.221.56; helo=ile.mangn.com; envelope-from=department@cdczsk.com; receiver=lists.ozlabs.org)
Received: from ile.mangn.com (ile.mangn.com [179.61.221.56])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMRjw1jCcz3dH4
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Sep 2025 02:59:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cdczsk.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GrRrNTBmtAg3NKzjCEDPNODlg6dNaZnbmOpgy8NOndI=;
 b=p8nwOd+HrWJQMiEU+bWvA8utoEEkHaM7mO8qdpG0S+95VQK4NMXEnlx6e6XP6HX8vpQfrvmtA9bI
   lmlYyIEmzztzjxuuZ5/09M5yoieO+kP7+mqstzvuo/GgGyjsbOOzQiNYj3rOJxqiaGlqkNpSLTJV
   6UeI2ycqprVZyyZBjF+pKMRSvNEbkHpDD0cbZLGq32VH06imVN3wdWtCbDHuFxGw0Q6/cYKibAVp
   5VGjE8WhWXkU4PqgpIo3dEFSuM9h3YiTLCoFoIoQqWDfb02fInsdnH1EYlgoF6ftEJTJsdf0HceA
   g/Jx3zNXLxBHfV52uDWfj/LfUVCw0zb02kn1b1qh+tAa/qUD+rVrN+IDJuCb4mZDeNXDC+YspPwI
   eWIX4TZo0a9YO1G2KUxHiZ5AKJx/rWBjmwxfD5u+mwVmyInHZ1H6+bslsmimpiiS/7CTpvc5gHhJ
   nTrAlL4olNF3r4krzSNFzth9oQkgk5mCZk2jtf1wjlGdgTtL8mG8pgSvOELozJxyUOS3GzndSUIY
   yia3mqGEoV6HpD9KCUVn9oS4SC5kr+lz71hh/1jI/0rEJIDlmSCvnpzz+8CBPt5MxhrKRzgiNSac
   HOUWe2weHgeXV2RdOt/L1BKZVUew3u4j893DZubFvNsCIExMe0qVJWGZ3Ay+QTZay+ZeQ9OaB0s=
To: linux-erofs@lists.ozlabs.org
Subject: did you have any questions about products? h
Message-ID: <22ddedc3033bff0d55813ef175fe63c6@unknowserver003>
Date: Wed, 10 Sep 2025 16:39:20 +0200
From: "Peter H" <department@cdczsk.com>
Reply-To: dep@cdczsk.com
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,SPF_HELO_PASS,
	SPF_PASS,URIBL_DBL_SPAM autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
</head>
<body>
<p>Hi,<br /><br />We are a professional manufacturer of e-bicycles,
producing over 50,000 units annually and exporting successfully to Europe,
<br />the USA, and Australia. With hundreds of customers and distributors
worldwide, our reputation is built on reliability, quality, and fast
service.<br /> <br /> To better serve our European clients, we keep stock
in both our EU and US warehouses, ensuring delivery across the EU within
just 3&ndash;7 days. <br />Whether you are interested in purchasing for
personal use or considering becoming an authorized distributor in your
region, <br />we would be glad to support you.<br /> <br /> At present, we
are promoting two of our best-selling models in our European warehouse:<br
/><br /> 20-inch Moped-Style Fat Tire E-Bicycle &ndash; Equipped with a 48V
15Ah battery and a 500W motor, designed for power and style, <br />perfect
for city commuting and leisure rides.<br /><br /><img
src="https://www.holaty.com/cdn/shop/products/OUXI-V8-1-768x768.jpg"
width="600" height="600" /><br /><br /><br /> <br /> 26-inch Fat Tire
E-Bicycle &ndash; Built with a 500W motor and 48V 15Ah battery, offering
excellent performance and range for versatile terrains.<br /><br /><img
src="https://cmacewheel.com/wp-content/uploads/2025/03/cmacewheel-ks26-26-inch-fat-tire-electric-bike-7.jpg"
width="600" height="600" /><br /> <br /> If you are interested, please
share your address and we will calculate the possible price for you. <br
/>We are also open to discussing exclusive distributor partnerships in your
area.<br /> <br /> Looking forward to your reply.<br /> <br /> Thanks,<br
/> Peter Hans<br />Manufacturer of e-bicycles</p>
<p>&nbsp;<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br />send address to unlist<br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br
/><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /></p>
</body>
</html>


