Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E29B54DE524
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 03:21:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KL4PV41ylz30QC
	for <lists+linux-erofs@lfdr.de>; Sat, 19 Mar 2022 13:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=L4Rm7D8C;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::112d;
 helo=mail-yw1-x112d.google.com; envelope-from=songmuchun@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=L4Rm7D8C; dkim-atps=neutral
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KL4PL4KfZz3089
 for <linux-erofs@lists.ozlabs.org>; Sat, 19 Mar 2022 13:21:08 +1100 (AEDT)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-2e5827a76f4so108305427b3.6
 for <linux-erofs@lists.ozlabs.org>; Fri, 18 Mar 2022 19:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sCZT+zb7EAFnc6hRGhTEdVJUiTHs/qJW5IO9CJAQOWU=;
 b=L4Rm7D8CY/Cy1ItHtYjZ+zkXORPWp0pJGh+Usl1EQm/ngUTzG0x49cbRDbFNase4ds
 ttWjz57n96zbgo2S09nW5pp/61QCoum8yjBa5YMMaLsM5RfShwVfEVKgdbfCvpkpyDwB
 O5rKlkfrYJvVBw1ilfZTV7/G3YLRCfHrG2HKbSvQneNFHItNzhpJ8U0H0FMCuulnYmN0
 kAAKNvi7JSe5L+8vZtads4j1YFtI/5bBpubOCasgAOlHPIySkboA3+y4goPlq4QA+ny0
 eLdgPEU+Gb8LijLucwdV5RN98wBWXPO48g8OJoCgbxpCAgcIpOjw8TxICSruv6xlae87
 YFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sCZT+zb7EAFnc6hRGhTEdVJUiTHs/qJW5IO9CJAQOWU=;
 b=TW/a7RctroOfxv+bRzT3g4b5UfWKeObcX7S1UcoFetRvYttgQfRlkj9LP7bqOuQQPX
 tCFlyZ087M4zsL9Xdrezcl3hH1BfwM5mzQ5TzUuLULOynB1uBLvgBvUzgqweva+S3RIb
 SCEq/gIyCY9plJJkw4vHwGfZaI1WH0NyLdBLdcPWz/X+LGB24T/Y/ADO844vz0SLQZf3
 +MjN7XvMsA6V9F+TUvOPT2qp2WNOjEivPwzK6/M+0k3hpzcGhs1A0SUnQkjQn2bY09MH
 iLtW45wMLIb7z76xGfNyZqYkpV7WHylIWdMbL/JT8+10IeMb7V3m+7Trcl5mr9dGQ6+7
 oMdg==
X-Gm-Message-State: AOAM5329eDLkTkA1SGYVqt8MCuPfCDBu7DxiLYAIYYDQasiuS6WUsN/t
 V2tEkfP+k2OBvEyLnBaLGqbBk1A7gg17w35AmXtMWA==
X-Google-Smtp-Source: ABdhPJxedKVItQZjB0XAwvylwOmrCH/rILDsFqkrh8ho0TeJVllNoHD5cX3XGmiHQg2AlPTJIHh5MI4bJ6NUkWDKzS0=
X-Received: by 2002:a0d:d203:0:b0:2e3:3db4:7de1 with SMTP id
 u3-20020a0dd203000000b002e33db47de1mr14219633ywd.458.1647656465178; Fri, 18
 Mar 2022 19:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dda2f905da80c934@google.com>
 <00000000000009cf1e05da85bb31@google.com>
In-Reply-To: <00000000000009cf1e05da85bb31@google.com>
From: Muchun Song <songmuchun@bytedance.com>
Date: Sat, 19 Mar 2022 10:19:12 +0800
Message-ID: <CAMZfGtWL-2+en7=FKBoPUwq1FMGYYqZCvB1jmJ7fhiQc1XX4oQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kobject bug in erofs_unregister_sysfs
To: syzbot <syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, syzkaller-bugs@googlegroups.com,
 LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Mar 19, 2022 at 6:33 AM syzbot
<syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 2768c206f2c3e95c0e5cf2e7f846103fda7cd429
> Author: Muchun Song <songmuchun@bytedance.com>
> Date:   Thu Mar 3 01:15:36 2022 +0000
>
>     mm: list_lru: allocate list_lru_one only when needed
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1495694d700000
> start commit:   91265a6da44d Add linux-next specific files for 20220303
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1695694d700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1295694d700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=617f79440a35673a
> dashboard link: https://syzkaller.appspot.com/bug?extid=f05ba4652c0471416eaf
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137f17d9700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114ebabd700000
>
> Reported-by: syzbot+f05ba4652c0471416eaf@syzkaller.appspotmail.com
> Fixes: 2768c206f2c3 ("mm: list_lru: allocate list_lru_one only when needed")

Does this patch [1] fix the issue? If yes, I am confused why the Fixes tag
should be the commit 2768c206f2c3?  What am I missing here?

[1] https://lore.kernel.org/r/20220315132814.12332-1-dzm91@hust.edu.cn

Thanks.
