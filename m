Return-Path: <linux-erofs+bounces-470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80826ADFC66
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jun 2025 06:29:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bN70j0Kt4z2xpl;
	Thu, 19 Jun 2025 14:29:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.70
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750307348;
	cv=none; b=Cc112l8yLu9w6MXD9U5bPvfEW4/C9y6X7Lqt5rIUnnpp4jKDPCLtW24mqFIBG40QbIOIRYoYB9upEVDscu2VnwseZJN4bi2ym+GKpZW3DJ118agDG9wfeRthRNAgRVFLuHNovwLVMkW0kXRdSXkg/cdlwHi/uYosKxR/9fbYqOYg581y7aKGb6BN1shUYGEqITkbcBsbYbhfalghj7xw+ydpQpI7hndGscHDmaYFFC7+xYcLRTl0dIGySqzyWkwRaYsnxhapLQCnWysK98RalPyhKeajSvrc8ROvvbGh+AFnaQjIE/vCHd80JH+NXwLczxIyqJ7TM+Ijkc+4JrnSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750307348; c=relaxed/relaxed;
	bh=0RTBHQGJ4o6rnPsqSnb4biPDUygoMp38eBwORzFpO5c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J0QbinV+QZvegrvvmoZDiUqpMIE2gzUucLj4l5uFPCqqaBuIU+rB7SFrRi5wSiwJQRejNd3rPySy3EhSO7IxeCAChTBR4q/3xvLpYlxcEjCDr+rS9jteeY/7i9oqulwiZ/BDxGkvt2XJ0VcU2WxTLCSq+STiLMKTtWzBTdbUwVXeilNzsz9/wTnm8zv63iOTno8nFBzsUAidyXA5hqUB0ap6RMrwQdoOG2tNvVXcZRt0uQ92UtCZ49NfRs72Jsdp8LEHXZew7rstjiXj7ZAck1U92NbaqWbdmzoFyBJ5wuvEoECEUkv1G0oMHmoTU421dzfwMSx2SpuzvZ9aXDg7Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3dpjtaakbamk7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.70; helo=mail-io1-f70.google.com; envelope-from=3dpjtaakbamk7dezp00t6p44xs.v33v0t97t6r328t28.r31@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bN70g4jmGz2xck
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jun 2025 14:29:06 +1000 (AEST)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so29625239f.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 18 Jun 2025 21:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750307343; x=1750912143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RTBHQGJ4o6rnPsqSnb4biPDUygoMp38eBwORzFpO5c=;
        b=HkST9fTAmvNc5y/kIwVZBF1wX5Vi6gwq/8WdugiUX/0I2yBZTIV47wZlEpCVwNGfsV
         /07aFNqAlM4OOPdVxVcPx4NlmyhvPcsf7o9rBDGRddKna3NhOuvmGmMAppF5NzIOqZK5
         Q9Q8RcqBoY3BckLWlUpcQM4zSsxEnpZ94PkKhL5BKYMKv2IjLn/F32bNs0BdEjNQnfoZ
         1nM1KbFbrQHy39ERpeAyR0MuXctKbZZq84/+QMdw/2ZbKeaTK196X1P8yMYPec4eVXCK
         Jx9/qWpAymJch544zBoknldWKTDsFYKJmjPqkde7qPp+xuDD7fWa9ogv47HXxEHa4eNc
         sKNA==
X-Forwarded-Encrypted: i=1; AJvYcCWfzubRqYqc5BkLEFQLVMDpL0kScmq8zC4Aft+/8Tm2fEgf5e8G+2uul9BIX3+sELwCYiYcKLftqqXODg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxUSZ22E2wYSt17na2Rge6c7TJA6P1mo8NZudv1blXSccKUiOIa
	vZ8bWNuVNG6AirQavntXdDcu4YctPaTTGQwKtmoswNKsga+Vzgj//C25eH8Oh9nOdM1QIwrN/Rd
	v1I9InkFKjHBCBg1lPDYCJe8wzoLP2Y9bqQtw8K4uQACH2ns2b10dVAM1DyI=
X-Google-Smtp-Source: AGHT+IH47ft2xBqsJgNwYhR12OCsOlAJNYrhkFplkeG8vasj3H+hW021FoknFfn/xqeoMarDrVNpaeHDJAZFMByJK1zAcJtHLgQ8
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
X-Received: by 2002:a05:6602:3fc3:b0:875:acf6:21a with SMTP id
 ca18e2360f4ac-875dedc39afmr2217590039f.11.1750307342971; Wed, 18 Jun 2025
 21:29:02 -0700 (PDT)
Date: Wed, 18 Jun 2025 21:29:02 -0700
In-Reply-To: <5a513fca-b8cd-40b9-9b28-9793cf80e293@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6853920e.050a0220.216029.0165.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (5)
From: syzbot <syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.3 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Tested-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com

Tested on:

commit:         0097d266 erofs: refuse crafted out-of-file-range encod..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1732b5d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=162faeb2d1eaefb4
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

