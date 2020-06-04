Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD151EE74D
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jun 2020 17:05:42 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49d8Gq14GfzDql9
	for <lists+linux-erofs@lfdr.de>; Fri,  5 Jun 2020 01:05:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1591283139;
	bh=Ped6Hc2iccrDw5oNXRa9HJPyL8UEzrObOJFy/JWBB1k=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=hItw9Jp0y8v/blB6/ki2oZT6IBJHy8m9Gnj3Je28g4u7SeD8SiTGU0bdG7Em1BYEd
	 DcGYYTAAIOXXZrLa/yeNnGDYOdi2jIHzyDuJA4UwVz2/DXT2F1sJpAeMi05HrBJ28Z
	 qDQChop+TuScp0p1CCLZtgMK1nAs7JqOoOplw3cvU2CnhU8o9+8qI27gXrkVUddJBx
	 tfS381aWLUA6UwtjrBTWbtsLvQUe31HxTwQQbpByUOran/isXh1szi5x6+Tjp4cLQh
	 6TbtyzhtXddzHxFzdP9Xiho1DJTjs87cFg9CKR6aB+In7YMdm7qsLOQPSoOG22qE7N
	 fxEFR+h3G1nHw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::32e;
 helo=mail-ot1-x32e.google.com; envelope-from=forwarding-noreply@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=iltQGLu9; dkim-atps=neutral
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49d8GX5H8VzDqXb
 for <linux-erofs@lists.ozlabs.org>; Fri,  5 Jun 2020 01:05:19 +1000 (AEST)
Received: by mail-ot1-x32e.google.com with SMTP id v13so5012941otp.4
 for <linux-erofs@lists.ozlabs.org>; Thu, 04 Jun 2020 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:date:message-id:subject:from:to
 :content-transfer-encoding;
 bh=Ped6Hc2iccrDw5oNXRa9HJPyL8UEzrObOJFy/JWBB1k=;
 b=iltQGLu9ABzBLwE6QoUKmE13CAjpS7gOAdxMzEAnM/fBGhK98FynoSfRNfvg9Bbx5E
 BkM5cV6QmwG9SRZMpxaCMXgwLR9iZJty/xsge2GzXE5hm/7zqAiQ426hdbrgDU/vWR5G
 DFxz1Oqh/42KsWQ9tGbte6WcLe2baTBXuggbbnDRzgYnTWfMD4K1MqBQ6FLm/ZVrmQDj
 oDhPtiw4cZrNSr5U+pf2VIFiCV7Duq+XKv0i9gEZ4en3HCXNPMKAPnw5BNzv1VpJt3QJ
 FW6F6YIrEa9ng5zNF/i7ktVFToqXkDrdxsQUZJHKLn+3FvaeZq4n0PVSQ8zbhJtVHsH3
 PKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to
 :content-transfer-encoding;
 bh=Ped6Hc2iccrDw5oNXRa9HJPyL8UEzrObOJFy/JWBB1k=;
 b=hXCgpS8rzlXLs1zlVnMYUt/3tLdAVoDcj6367i4oCFjtFpZQIBA3WTGhGBmtypiYb3
 gj6Ya6jtRuEKhj5+spmTgm8ENhjYL+TM0uPoXpg+zhL2ZeOJtMkTiUcCoNpUVPimk1aR
 umtoUVhFcYaG2ll7kOCbvtXxm9L5At3jQfjoClctMGVn2RGTetmFKYUgenOsXsQUCWig
 3BimyhvEiQU/kRIRrW10miJVywZSmPv8OQEJQWNcv2vqJciIddHqplpNB4rT1lz1BoBO
 XqWZkUTR6C7cCyEWi5GXEriJWUoDcy7E6rAG1LzyIQZ+Qst2MWSl3CFd8B2+Cx4wXy4Z
 C2wg==
X-Gm-Message-State: AOAM533hOTkNnNBg/JIQ8yK9cKkDwDF4FkDbcefUwHesKXRt99Ui3/og
 ggztowdzQwfnj+q4zOlmoOefVm8TQCT/9VuWatutCm54nNBY9uGHFcI=
X-Google-Smtp-Source: ABdhPJz6/4rqBint6vmmIfYt177cDMjq6u9crdeTHmsli8q7cCCNz++dbdxX1upbs0MEmYMDHKSnnFxpUJOHASI9B4Xnm9foqyEw7Q==
MIME-Version: 1.0
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr3815487otk.181.1591283115291; 
 Thu, 04 Jun 2020 08:05:15 -0700 (PDT)
X-Google-Address-Confirmation: 9WpnwHBH5ysv_syeZcT557XG-4Q
Date: Thu, 4 Jun 2020 23:05:15 +0800
Message-ID: <CALJidXFONTrQCbjDpM+yJeJswZ5Kt56rge9o91fnX-k6qq6L8w@mail.gmail.com>
Subject: =?UTF-8?B?KCM0MTY3MDQ4NzkpIEdtYWlsIOi9rOWPkeehruiupCAtIOS7jiBibHVjZXJsZWVAZ21haQ==?=
 =?UTF-8?B?bC5jb20g5o6l5pS26YKu5Lu2?=
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
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
From: =?utf-8?b?R21haWwg5bCP57uE5pWs5LiKIHZpYSBMaW51eC1lcm9mcw==?=
 <linux-erofs@lists.ozlabs.org>
Reply-To: =?UTF-8?B?R21haWwg5bCP57uE5pWs5LiK?= <forwarding-noreply@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Ymx1Y2VybGVlQGdtYWlsLmNvbSDlt7Lor7fmsYLoh6rliqjlsIbpgq7ku7bovazlj5HliLDmgqjn
moTnlLXlrZDpgq7ku7blnLDlnYAgbGludXgtZXJvZnNAbGlzdHMub3psYWJzLm9yZ+OAgg0K56Gu
6K6k5Luj56CB77yaNDE2NzA0ODc5DQoNCuimgeiuqSBibHVjZXJsZWVAZ21haWwuY29tIOiHquWK
qOWwhumCruS7tui9rOWPkeWIsOaCqOeahOWcsOWdgO+8jOivt+eCueWHu+S4i+mdoueahOmTvuaO
peehruiupOivt+axgu+8mg0KDQpodHRwczovL21haWwtc2V0dGluZ3MuZ29vZ2xlLmNvbS9tYWls
L3ZmLSU1QkFOR2pkSl9JNmNjb2YySTIzNklhUXdhY2J1bzNYeFl6WU8yckYxbHAzaENSSklEUmxv
TVVaRU1tZDMybjg3UXRLY1FoR3QyN096N2o2X1VsWDZyNjdMQksyNDZTUVpka0lpcV9GandkbFEl
NUQtWDFnSFN2andsNFgwU2lOUGZqZGcyX2tWVDdjDQoNCuWmguaenOaCqOeCueWHu+atpOmTvuaO
peWQjuWPkeeOsOWug+WPr+iDveW3suaNn+Wdj++8jOivt+WkjeWItuatpOmTvuaOpeW5tuWwhuWF
tueymOi0tOWIsOaWsOeahOa1j+iniOWZqOeql+WPo+S4reOAguWmguaenOaCqOaXoOazleiuv+mX
ruatpOmTvuaOpe+8jOWImeaCqOWPr+S7peWwhuehruiupOS7o+eggSA0MTY3MDQ4NzkNCuWPkemA
geiHsyBibHVjZXJsZWVAZ21haWwuY29t44CCDQoNCuaEn+iwouaCqOS9v+eUqCBHbWFpbO+8gQ0K
DQpHbWFpbCDlsI/nu4TmlazkuIoNCg0K5aaC5p6c5oKo5LiN5om55YeG5q2k6K+35rGC77yM5YiZ
5LiN6ZyA6KaB5omn6KGM6L+b5LiA5q2l5pON5L2c44CC6Zmk6Z2e5oKo54K55Ye75LiK6Z2i55qE
6ZO+5o6l56Gu6K6k5q2k6K+35rGC77yM5ZCm5YiZIGJsdWNlcmxlZUBnbWFpbC5jb20NCuWwseaX
oOazleiHquWKqOWwhumCruS7tui9rOWPkeWIsOaCqOeahOeUteWtkOmCruS7tuWcsOWdgOOAguWm
guaenOaCqOaXoOaEj+S4reeCueWHu+S6huatpOmTvuaOpe+8jOS9huW5tuS4jeaDs+iuqSBibHVj
ZXJsZWVAZ21haWwuY29tDQroh6rliqjlsIbpgq7ku7bovazlj5HliLDmgqjnmoTlnLDlnYDvvIzo
r7fngrnlh7vku6XkuIvpk77mjqXlj5bmtojmraTpqozor4HvvJoNCmh0dHBzOi8vbWFpbC1zZXR0
aW5ncy5nb29nbGUuY29tL21haWwvdWYtJTVCQU5HamRKOFhRVUNHRlZQVUpsSGlHcFpXb1VpRU55
am91dWZSSlQyVkJxc1NnRm9ITmQzeDhIWFpjNzdHUTVnRWlFbWxyRTJXcks1UkdxXzBkSk5tX1B3
QkxHR1lJQXdscHBTN0MzOVdSZyU1RC1YMWdIU3Zqd2w0WDBTaU5QZmpkZzJfa1ZUN2MNCg0K6KaB
6K+m57uG5LqG6Kej5Li65LuA5LmI5oKo5Lya5pS25Yiw5q2k6YKu5Lu277yM6K+36K6/6Zeu77ya
aHR0cDovL3N1cHBvcnQuZ29vZ2xlLmNvbS9tYWlsL2Jpbi9hbnN3ZXIucHk/YW5zd2VyPTE4NDk3
MyZobD16aF9DTuOAgg0KDQror7fkuI3opoHlm57lpI3mraTpgq7ku7bjgILlpoLmnpzmgqjopoHk
uI4gR29vZ2xlLmNvbSDlsI/nu4TogZTns7vvvIzor7fnmbvlvZXmgqjnmoTluJDlj7fvvIzngrnl
h7vku7vkvZXpobXpnaLpobbpg6jnmoTigJzluK7liqnigJ3vvIznhLblkI7ngrnlh7vigJzluK7l
iqnkuK3lv4PigJ3lupXpg6jnmoTigJzkuI7miJHku6zogZTns7vigJ3jgIINCg==
