Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA048344B
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 16:49:07 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462yFX6wcwzDr2J
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 00:49:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="f6XcpSav"; 
 dkim-atps=neutral
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462yFR75YgzDqkT
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 00:48:59 +1000 (AEST)
Received: by mail-ed1-x52b.google.com with SMTP id w13so82627075eds.4
 for <linux-erofs@lists.ozlabs.org>; Tue, 06 Aug 2019 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=pBm/J3PgHIa4qP5C5yz7He+tg7ZRNQ/TWTJXyDm/pYo=;
 b=f6XcpSavj6Ndw3Rw8bhtmcgoZ6YXhviM/MphDrTwdIWXucn7aUUAKDyjRpsVsPo6XB
 pDx+wCApzpTfRcENdpIPZGp7lVFZdqZqX5eNHsK4UZd3D6a7Q7cMpXQ30LHJ7F+B28eY
 9NUY7AJPqmjj3ijGs7kob9RBBqbspr1Dj6YFuV2n9QaXDdgBbwNB6/oSNvsAp7fkw/LD
 XOuq2F2YhJROn0F3/TRpiuAVlUe+BjLI+jH9OjtC9zPtpZUYenhW39bXbbpYPJAkWwqP
 pkXDQfmsoc6djtwROFg6tCHQ3lAx91B6gXDjL1APeFZoHVAdYCti0vIge8GBaBHUNqPw
 7Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=pBm/J3PgHIa4qP5C5yz7He+tg7ZRNQ/TWTJXyDm/pYo=;
 b=lWE2J9cvEiRxpqEDbmmSOBam9+C3YXq4dFl5zXIt6ZV8IovGxw/gwYJlNWjXLjARv8
 7heHOELqQ/8ecE94p7Jtr4vQUJjtHzs55jQ1aCm+o1m8KDKKMePMoR0aSmgLMJP5L1fj
 7klZlbhcIaWIUxgmfivIZB/Cvn6qpH5GI5CH+nZ8eQU5468yNa9n652QBFouFEBgG4i5
 P1FtNl/r/eTw/fbrtVWnwcDTeCTF2LukybgDpIkI7WJ7+rp7cA2K33ZmMUopqgzo1Sxq
 hvotZztLDQ3HG3Aw84vPAZw0rLBgRIrnuiToTiNlN0WJ0PrWHZfdjKnrC0FWGHgpkxRT
 bF1w==
X-Gm-Message-State: APjAAAUZgb1delXLOzCRPvNAEiCHIhIk/KqY5JbW/BODKNWyU5O4nIbd
 cSDeN7U2VoBoaqoNfHLqNfI9Pe2YTwu8KxIuYvEgvA==
X-Google-Smtp-Source: APXvYqwyHAihw6xqaRNAwktKcVqtJzSq30t/x5hwUZlyRTA5E6b1S1nJALVlV8HoJzfamqKLYfllKaXDZnbhPFjcexM=
X-Received: by 2002:aa7:c509:: with SMTP id o9mr4309516edq.164.1565102934431; 
 Tue, 06 Aug 2019 07:48:54 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Tue, 6 Aug 2019 20:18:42 +0530
Message-ID: <CAGu0czRhmT7vSnFB-9pnJS=fhZp7RFL2ZwYfbc1RK-p5ddQ6tw@mail.gmail.com>
Subject: Test case suite for erofs.
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000719cd6058f73ec46"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000719cd6058f73ec46
Content-Type: text/plain; charset="UTF-8"

Hello Maintainers,

I wanted to ask if there is any plan for writing a test case suite for
erofs. If not, how do you think is the idea of having a dedicated test case
suite, so as to maintain quality of fs?
Let me know your thoughts.

-Pratik

--000000000000719cd6058f73ec46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello Maintainers,<div dir=3D"auto"><br></div><div dir=3D=
"auto">I wanted to ask if there is any plan for writing a test case suite f=
or erofs. If not, how do you think is the idea of having a dedicated test c=
ase suite, so as to maintain quality of fs?</div><div dir=3D"auto">Let me k=
now your thoughts.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>-Pratik</div></div>

--000000000000719cd6058f73ec46--
