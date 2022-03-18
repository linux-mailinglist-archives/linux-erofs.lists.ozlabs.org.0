Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0674DDF2F
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Mar 2022 17:39:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KKqV43W2lz30NZ
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 03:39:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 (client-ip=209.85.166.197; helo=mail-il1-f197.google.com;
 envelope-from=3sru0ygkbaak178tjuun0jyyrm.pxxpun31n0lxw2nw2.lxv@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com;
 receiver=<UNKNOWN>)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KKqV00DDFz30Kq
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 03:39:18 +1100 (AEDT)
Received: by mail-il1-f197.google.com with SMTP id
 q6-20020a056e0215c600b002c2c4091914so5096473ilu.14
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 09:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=zlcZQJRzABd3RTz1DlZlJZFkimZoZeNYcCzNjgSADtU=;
 b=LbiGK7NHLxv+qZYY+Fi+5iNb+MmzHURoQIST6WNeYPd9Mnc8EvFdGko3lO/33AFlh9
 ymGeIzit5XjlGjKyy+05D+y0Oi4R/PEfYhy3pXUr4CpmfA22+SitFdE9p5CTav0DtBVW
 a+d6bWTw4SqTJOMCX5SoV9Nuw5wbUFVWNrjZB9x70rcZkLtUhU1rx7AdpmsKqq9zEoSQ
 CKmM/ggx3xQaRzYou8rd3XdueSVdnx4R3DhU1vdJ5sFKoFoQRYlo5YXrhKjJbD8r5IQa
 6pb04PY9F6WhqGo1KBqiUfCqe7jKgeVRGnfEV5bjB7Bukjoz9d6lX0TE7+2KZurGSkKF
 Du1g==
X-Gm-Message-State: AOAM530OLlGHzGRpeQyoykavtpEY6lD63jyH0LM091IfBKYq6LAUKg4y
 29KPL2NZxyacuO4+QJrgqhjWzXw1gRkouiUpUwksCvxBuLdx
X-Google-Smtp-Source: ABdhPJyD/F1Ep/lGBj6K/8at1J+63IyzG9SJRZFcP9HxPySURgrSeUvV2S8rLxjXh/5bW+YwZ9+S4P3JuEymgPHgCWfilx4HxmF3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c52:b0:646:2488:a9a0 with SMTP id
 x18-20020a0566022c5200b006462488a9a0mr4909882iov.130.1647621554998; Fri, 18
 Mar 2022 09:39:14 -0700 (PDT)
Date: Fri, 18 Mar 2022 09:39:14 -0700
In-Reply-To: <000000000000ede59805d5d31c36@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082940b05da80c98c@google.com>
Subject: Re: WARNING: kobject bug in erofs_unregister_sysfs
From: syzbot <syzbot+045796dbe294d53147e6@syzkaller.appspotmail.com>
To: chao@kernel.org, hsiangkao@linux.alibaba.com, huangjianan@oppo.com, 
 linux-erofs@lists.ozlabs.org, mudongliangabcd@gmail.com, 
 syzkaller-upstream-moderation@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Sending this report upstream.
