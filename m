Return-Path: <linux-erofs+bounces-1015-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F759B51DE3
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Sep 2025 18:37:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMRDT0g93z3dJ9;
	Thu, 11 Sep 2025 02:37:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=179.61.221.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757522233;
	cv=none; b=mDsd2AZ6BcKlK9ewyoh++XrEbSiJNKv9VkHDUxafdwLeai0xY+rg1IUr0lH0UMOILzJMQpwYCcofn6cvPhEM+55JAcnvM4oXMx5WHqHP3B5UZDeMRPpx/lOiifdhbo4LbFalz0Ufk6aeqoTbxXv13cVsZv4pan/zoCyqC+XMKW60hgD15NAnwKJAqPoRUWlEaLKpmKa64xTyXjebvWBJsg1XFfq7R1WkqxIV+dUJVSOjPPS8Ht296x4oFRsDxkDUKHALs4iT9yRMiYIqqcJG/9HMzCczkZSzxMGR+8o+O6ykv46cfdwLwG7P7b73LwHrz9R62LtRYOjJnbMkivyTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757522233; c=relaxed/relaxed;
	bh=GrRrNTBmtAg3NKzjCEDPNODlg6dNaZnbmOpgy8NOndI=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=HsRCXuvA6oPQsX/buCr6D0v1vGoM3Yl3Mj3RgpyHGn2riME32nCAwaJDFbdnHk1Q3q+EV3MunNF6Wbftcm4MAxjkGerZbVKX7BStQOE2nd0hhtG7ZpWWQQG/Jo5scc55YQ2HxeeheNduFdUb9NQ5NpUEnIC4OimkSl+OLD+tglav3mOrYztQ9hmnEns+V4juDU316zRXHLm0Rx/0iExMNcQm3K0TZrE4byvOtdWQ0SxbUOgBxoTfnwl5N6Qndur9RXASK63znIEZEU9opHkespxr14gHV/0q0H9NnzMbVlJI8VXt+2l6EV4xAGIRoiM2iVju8ZHvI2LZkYf9NNwVuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdczsk.com; dkim=pass (4096-bit key; unprotected) header.d=cdczsk.com header.i=@cdczsk.com header.a=rsa-sha256 header.s=default header.b=iSyblBsV; dkim-atps=neutral; spf=pass (client-ip=179.61.221.56; helo=ile.mangn.com; envelope-from=department@cdczsk.com; receiver=lists.ozlabs.org) smtp.mailfrom=cdczsk.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cdczsk.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=cdczsk.com header.i=@cdczsk.com header.a=rsa-sha256 header.s=default header.b=iSyblBsV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdczsk.com (client-ip=179.61.221.56; helo=ile.mangn.com; envelope-from=department@cdczsk.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 2295 seconds by postgrey-1.37 at boromir; Thu, 11 Sep 2025 02:37:12 AEST
Received: from ile.mangn.com (ile.mangn.com [179.61.221.56])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMRDS0wGNz30Pl
	for <linux-erofs@lists.ozlabs.org>; Thu, 11 Sep 2025 02:37:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=cdczsk.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GrRrNTBmtAg3NKzjCEDPNODlg6dNaZnbmOpgy8NOndI=;
 b=iSyblBsVc9jW89gZA4gzhMkv0dLa9ZzBM9HOtuheexcM+LLMQ2nQjpR7mQ4K8YSi6zsPTjVbzMFC
   8y6w3YVTDarS1hVKjciwLjsHBZc0aVsJiYClMuDtghjlOXlfWxCVBLZHSZVEKCwrTfGsk7urH6oA
   yjW2a1iKf0Ewf3n3dRDGyamDab7fOFvYz9uBaps6Wwh6aHmhVM4F9sJRZJ33uBSE6p3Yj7OG8bqB
   VZcoHaOPCI6uD4eUzDh8MLfAGdsgAWo762HfWqYsVIisiCiMwy2wB2eEJz2leHsI0pZaZqovzHTe
   oLvhvq0HQ1CKF8n5DVzZsyV8JgZCO9Xl+Qoz8zcVZldS874aScS2PzmoanLvjw+wexlfXKSan0qM
   wGy7RcpEtXHJzV9JuCKU4Swkp4PMaA+8abEWe7NGSr1BQc6l0+xYKzoUPpuikXMvLipB7joeLvoL
   cv4O7+TrTS5XXWrvQErBVEErS4EVUM+HVbJ25x/CYoRnRpbV61Szy8jtAjkncZTg286CleacyBJE
   5apmzZW1lRDWstiVQ3aHX0PDQ7nG24Ef7og1huki8djODdY5KDTy4OXJ52QvNr4jio6raC2VH3Gh
   lHEpzfy3qyBltz/kL+97Vlqqf7forSLpzAW6l7HQRwwTAuJvYs2epH3i+sR+5Uz61T5h5NRU3hw=
To: linux-erofs@lists.ozlabs.org
Subject: did you have any questions about products? e
Message-ID: <52ca4f4340c976b1eb33596ce188f829@unknowserver003>
Date: Wed, 10 Sep 2025 16:15:46 +0200
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
	MIME_HTML_ONLY,SPF_HELO_PASS,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
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


