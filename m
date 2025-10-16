Return-Path: <linux-erofs+bounces-1194-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABEBE55A6
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 22:18:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnfQy66V6z30Vl;
	Fri, 17 Oct 2025 07:18:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760645898;
	cv=none; b=a++vH9aTKsV5qE87gq5HY3OqeMF9kj2tQac9jQgIqbxeBxP9LhgXvf53+6xUgb6R+uA9mDIQiK8rvbne40xp0ljImGFw/YFbBxcCfRxhQHbqPu6S/trkiuZUSOkhnkJI6q4OWEKCCheDacxRstrFleLiUWZ7z3GD0ODBsE5fJpFiEz47hVKNYCQ5QRnIxqI/EocEpUgSUW5yC+KRT33U23Px5k9isyrOFbAI83GNTrlXvWpSEJ6Spo+OXxkRKrTyt8jWei/om1QLQHe7L7yzRFr60Kch1+Gqibyh6GqIThs9dKsxjBZmpfOmC9ylOpQ4wLkYtqB7208k3whu7Comsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760645898; c=relaxed/relaxed;
	bh=Sn2a1S5urwZDdncds03WgnUabQEzohYmDFpgHhdfZjc=;
	h=To:cc:From:Subject:Date:Message-ID; b=Hp/9FGyqSBt3ijZJV2F7vAYOmg7qCLXpHSmIK/O2UlMvcasAkxuy2C76QGH9EYVTEOKIZAtt2YCKFhyoqQOQNNbOtAVLUWy94EQfo+3/P/2kP7l+xroixMUbgBnTIOwsYjq/G+MMGx5dzkovbu9Jk+cy8euIx5vRzQYsoImKdUTKEpYnCYT0KH0jE2IEPhly4vnozsb1dOFCEORHsaHt0w5EYGUVN07Zh4AVowpBcNCVgi0WmcX6hka7DSX9GnjrrB9UZGXKiaczAIcf8eHfmmQ4HoS3cyVJRw3m3cbOZ4H4ou8gUbnfPSjV1w4/RbHXgxkQumFBU3+KfMyS1ocebQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=LZ5+Q2io; dkim-atps=neutral; spf=pass (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org) smtp.mailfrom=csail.mit.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=LZ5+Q2io;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csail.mit.edu (client-ip=128.30.2.78; helo=outgoing2021.csail.mit.edu; envelope-from=rtm@csail.mit.edu; receiver=lists.ozlabs.org)
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnfQv6W4gz2xgQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 07:18:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sn2a1S5urwZDdncds03WgnUabQEzohYmDFpgHhdfZjc=; t=1760645896; x=1761509896; 
	b=LZ5+Q2ioqVKs8bNHvC/LHf/IMRoYbGkAlrHP90HNOVKvgsKGjKWKXxGh2J2GcIIciDh4S1jLEdV
	C1IkJxwWlQBcZz7uwipfW+2aScODQ4qMVHPXaf/xheU1VzwPmjJJ6D/mJVl0CigbYJ/zgJ9gwfXl0
	qrkca8KOMebgK/WZ3q6roos5sS/Wyq+jN7HhHAV8rzY1+BZzKQtREtQGKwi3TqlwooRkt+aFzKC6x
	zG9DFapwAYp65xTLqCEZ9CvEf4+uVv12zaLwvpIyu3BWQ59yLrgxGNERWc9Ot+lAi5HLa6UVK8S1U
	/mkzw3XJIjS50V+Zt44gRbtGx3+tb+PyOANQ==;
Received: from [24.147.175.133] (helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1v9UQJ-004cuF-HH;
	Thu, 16 Oct 2025 16:18:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id C72762A95C8F;
	Thu, 16 Oct 2025 16:18:06 -0400 (EDT)
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
cc: linux-erofs@lists.ozlabs.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: erofs image that can put z_erofs_scan_folio() into an infinite loop
Date: Thu, 16 Oct 2025 16:18:06 -0400
Message-ID: <35167.1760645886@localhost>
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
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

This produces an infinite loop in z_erofs_scan_folio():

# uname -r
6.17.0-12747-g859be217ee9e
# wget http://www.rtmrtm.org/rtm/erofs6a.img
# mount -t erofs -o loop erofs6a.img /mnt
# cp /mnt/x /tmp/y

I'm afraid I have not been able to track down what is going on. But
one factor is that erofs_inode_extended->i_size is 0x80000000000fff;
changing it to e.g. 3 makes the infinite loop go away.

On the other hand, here's another image can also loop forever in
z_erofs_scan_folio(), but has a more ordinary i_size:

# wget http://www.rtmrtm.org/rtm/erofs23a.img
# mount -t erofs -o loop erofs23a.img /mnt
# cp /mnt/x /tmp/y

Robert Morris
rtm@mit.edu


