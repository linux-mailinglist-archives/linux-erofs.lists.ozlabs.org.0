Return-Path: <linux-erofs+bounces-1031-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FBCB57EED
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Sep 2025 16:29:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQS8L4vjdz2ygH;
	Tue, 16 Sep 2025 00:29:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.42.36.24
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757946546;
	cv=none; b=kMM0WlzpBfIMWY0rP7hviUFwnx4zbWMhyKubaIyYRoZYCMPAjgaa8pjsx7Hx+3m8V2zEahMpLGy1LvTPU+WIdn9s5/+WHyW9GaRcvhVBNlumwwCMfo6WGyeHT0WZWgA14fZLlHCdZXo7ZoFL+5G1vq1k0bHJPRF4XkKlZt2dyMNnkWPMdijcg5PyTnc6RIhVxpgnzmQgxU84L8rTKl2IMWhwmElwWHKWTQyRdvWKUIemVcbFY1YA+u3mUGl5+Tbcm3sA4sgRTovxbMp4lH2oPrBigCUrp+r46CnWxZBuTe3Sy7d0/WpwXqIotzLTyOg6XuGoR9Qh28XOOJEJgtgugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757946546; c=relaxed/relaxed;
	bh=Qo0kXkTika4RlSHQx5HB9873cXdqb4NB1WjBxNeBd2A=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=cGjewzgqeZN0YwrbJTifEeK07dHO7xGMmGJwDYb/UErlPyIJUYSK06Kovzi9TquR0bFf93VgyxknCLVfcQQp/ZHc8vjY+C0DnxBjpNHTI70TFro62twYhBUpBafmz2WVX5d7zcwPWrl2ySj3QTnUAUFlB+TaAkViYRhUfzz6jSJsocjSW9h8WYIiR0oBE2fhjoSnHkBiHUWgUBgXF35XSGzo2Z9P+PKIs/igcLvIigyFyvD0mrolGjIAn1uQE0bqAtii4sHeriFeyKOnZ877mzMeqS8GoiItowiJYhR35gkHSG3Sdp1A5moFVj1rnTpaQmIXVWqFqndqIKuyra4vVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uwbswd.com; dkim=pass (4096-bit key; unprotected) header.d=uwbswd.com header.i=@uwbswd.com header.a=rsa-sha256 header.s=default header.b=mPfi+EWY; dkim-atps=neutral; spf=pass (client-ip=193.42.36.24; helo=mar.456jk.com; envelope-from=ttork@uwbswd.com; receiver=lists.ozlabs.org) smtp.mailfrom=uwbswd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uwbswd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=uwbswd.com header.i=@uwbswd.com header.a=rsa-sha256 header.s=default header.b=mPfi+EWY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uwbswd.com (client-ip=193.42.36.24; helo=mar.456jk.com; envelope-from=ttork@uwbswd.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 7228 seconds by postgrey-1.37 at boromir; Tue, 16 Sep 2025 00:29:05 AEST
Received: from mar.456jk.com (mar.456jk.com [193.42.36.24])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQS8K6glcz2ysc
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 00:29:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=uwbswd.com;
 h=To:Subject:Message-ID:Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Qo0kXkTika4RlSHQx5HB9873cXdqb4NB1WjBxNeBd2A=;
 b=mPfi+EWYm+iIuDuuv+HoSC5mbuRLaI5dUMG74jrEVRqMfg4udUpJuNqkEvzih/gz+emdp7aH3eZX
   wix1avaZXkaVZ/cOmmMIHWp7PdDUgQ3sMdBckW7UV4Jk+HhIvH16i4G6dD+IAh+Hc3w+FqUccAjI
   ZAY+hLwhkcSEO8iQ1C5/zx3BJIsj2Lr6IsWGidn1CivQpF3793EJM4DHDiYAHYPJGsPZ0zmT9UuY
   778NVFNEgDtmMZ33AIRNyNgjdezqZgw6Qs9wfFC3f4oyU2DptyF/sPId0wovXcAC3E+9LDZDiCGS
   ybE+QgY8AClPf0m3MMDw0nbyTritP/bt302YvNLAfcEFxQPFQaCl8xgHuZKZlWraAmcy6H9hqYH/
   2G/IyfLkOz+K/Cv3bATg5s5ex1EyhrJFpFaBxYu2stpFffCOWtMC4Iiy7QLEO/Bx0llteruyCtzl
   Knw4DgaBn0D8qRXFieN36qf75u7viKdtoJLKhZ17TkwuBfAxgEUKhj70kPgzk4LePCcjj9gvuVTu
   /FESQSVFBvzj/9CgzLMWncdn7dxo2HUDVtpqmvPpVTxnthFF2cFD9Xdajk/h3tnIsbxWdNyDLO+x
   uLViNrQuUOxt+9mkStpZcu2T03NQ4Y5INWEYYkBRCpWnnYjma8i9SkRftMlscpp7xIrJrNsJJsU=
To: linux-erofs@lists.ozlabs.org
Subject: Are there any details you'd like to explore about our products? ap
Message-ID: <545905f2cbf22032a102b78160fdd0b0@server881>
Date: Mon, 15 Sep 2025 14:30:11 +0200
From: "JQ" <ttork@uwbswd.com>
Reply-To: contact@uwbswd.com
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,HTML_IMAGE_RATIO_02,HTML_MESSAGE,
	MIME_HTML_ONLY,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L5,READY_TO_SHIP,
	SPF_HELO_PASS,SPF_PASS,URIBL_DBL_SPAM autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  0.0 RCVD_IN_MSPIKE_L5 RBL: Very bad reputation (-5)
	*      [193.42.36.24 listed in bl.mailspike.net]
	*  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
	*      blocklist
	*      [URI: uwbswd.com]
	* -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	*  0.0 RCVD_IN_MSPIKE_BL Mailspike blocklisted
	*  1.2 READY_TO_SHIP BODY: No description available.
	*  0.0 HTML_MESSAGE BODY: HTML included in message
	*  0.0 HTML_IMAGE_RATIO_02 BODY: HTML has a low ratio of text to image area
	*  0.1 MIME_HTML_ONLY BODY: Message only has text/html MIME parts
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

<html>
<head>
</head>
<body>
<p>We are a professional manufacturer focused on the design and production
of electric pedal assistant bicycles, <br />supplying customers and
distributors across Europe, North America, and Australia. With years of
experience in the industry, <br />we have established long-term cooperation
with hundreds of businesses worldwide, offering them reliable products, <br
/>competitive pricing, and strong after-sales support.</p>
<p>To ensure fast and efficient service, we maintain warehouses in both
Europe and the United States. <br />This means that for our European
customers, de livery is especially convenient&mdash;all orders can be
shipped directly from <br />our EU warehouse and arrive within 3&ndash;7
days. No long waiting times, no complicated customs clearance, just smooth
and secure d elivery to your doorstep.</p>
<p>At present, we are pleased to introduce two of our best-selling models
available in our European warehouse:</p>
<p>&nbsp;</p>
<p>1. 20-Inch Moped-Style Fat Tire Electric Pedal Assistant Bicycle</p>
<p>Equipped with a 48V 16AH removable lithium battery, providing excellent
endurance for longer rides.</p>
<p>A 550W powerful motor delivers strong performance, whether for urban
commuting, climbing hills, or leisure rides in the countryside.</p>
<p>Compact design with fat tires, ensuring superior grip, stability, and
riding comfort across various road conditions.</p>
<p>Stylish and practical, this model is especially suitable for city riders
looking for both convenience and excitement.<br /><br /><img
src="https://ampedcycle.net/wp-content/uploads/2025/08/991A9682-1-scaled.jpg"
width="1000" height="667" /><br /><br /></p>
<p>&nbsp;</p>
<p>2. 26-Inch Fat Tire Mountain Electric Pedal Assistant Bicycle</p>
<p>Built with a 550W motor and the same 48V 16AH lithium battery,
guaranteeing steady power and durability.</p>
<p>Large 26-inch fat tires provide outstanding traction, making it perfect
for snow, sand, mountain trails, and rough terrain.</p>
<p>Designed for versatility, this bicycle combines the thrill of off-road
adventure with the reliability needed for daily commuting.<br /><br /><br
/><img
src="https://www.ebikescootermall.com/cdn/shop/files/poleejiek-dp2602-green-1.jpg"
width="1000" height="1000" /></p>
<p>&nbsp;</p>
<p>Both models are designed with safety, comfort, and practicality in mind,
combining advanced technology with robust frames <br />to meet the needs of
different riders. Whether you are looking to expand your product range,
supply local customers, <br />or explore new opportunities in your market,
these bicycles offer excellent potential.</p>
<p>If you are interested in purchasing, please contact us with your d
elivery address, and we will provide you with the best possible price.</p>
<p>In addition, we are actively seeking partners who would like to become
authorized distributors in their local regions. <br />Many of our current
partners started with a small order and grew into long-term business
cooperation with stable sales and repeat customers. <br />We would be glad
to explore how we can support your business with competitive products, fast
local de livery, and reliable service.</p>
<p>Please reach out with any questions or to request a quotation.</p>
<p>We look forward to the possibility of working with you.</p>
<p>Best regards,<br />Jonathan Qian<br />Factory of&nbsp;electric pedal
assistant bicycles.<br /><br /><br /></p>
</body>
</html>


