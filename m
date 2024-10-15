Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A758F99E2FF
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 11:45:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XSTjJ5WRNz3bpm
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Oct 2024 20:45:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.166.200
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728985506;
	cv=none; b=eTWw+s/WumawFxybMeiZzfjVJk+pQt8wuDwHNWv27MsFGwzQH9BJXUNsubBtxmYHVRhklSKWLMOVB6t3uYrNqB7DSqcso48xcIKoB7m9q0PmHmfxZlG+W+i5bGAPcSkCI4L8+2iAV5dgHyY4KJ4ktSmC+cZThZE/IyMRyL2Jc+49pjJau1fy3Xfx7iWmwRGmR2rBnDT27CJFJ+cEUMkpznZWeyY4W+UpYdyI2EtbQ9Xvs9o9XetWlMVH090k2qbOLV8Sn+LO+hPeCmmUSwTmikGEj74wqUMMESmfWu94Yuyml5M/iCrYK9w4idA31ifv2xynTezCXjhsQwff6fcOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728985506; c=relaxed/relaxed;
	bh=xALKlN2ovO2mb0V6amAaOMXvrsoZMqemd7QT5SbNimY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KCCK2cmmob3qQAMKPr1aCTuFj1fAcNsmqzbGhffP/jyecEdIgqf5YCCiJznXevOy+FKxqLxstEiBAOP7uLzxgHLwLqheKpHTiQQuIkYhAeJMF8245XyXxkr+/+J8gSKOsz9nJavGTgkq38pjC5x9sEEhgz4TmKrY+oYnhTBKT7Fs69ZlVqhfj7VGg8SJsTQqzjPBo0lzYFn2R3Lovkr6C/LVOXHwxBJsPI8yN3k/dF5PqeRJ4qENnjZmADXiw1uXf9wcKOl12hqJEka0zz8Xw4zgrhFwl6U+te7w+q5SKnIzPwHvZGxWKqrT2y/CGIPDpKJZ0/EtldUrsmXwCLqlgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3njkozwkbaik5bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.200; helo=mail-il1-f200.google.com; envelope-from=3njkozwkbaik5bcxnyyr4n22vq.t11tyr75r4p106r06.p1z@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XSTjF5h0Lz2yRF
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 20:45:04 +1100 (AEDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so29107505ab.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Oct 2024 02:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985503; x=1729590303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xALKlN2ovO2mb0V6amAaOMXvrsoZMqemd7QT5SbNimY=;
        b=dRBHJILlwHj8+05/9jiNir4I/hok2bqbZtDZ8k7/A0s9Wqnh4en/sSHuqdYR4wxzJr
         y8OsR1hca9Hse5PDLxWutUi68X9P5kATzM/ryAXd9i76d3ngqsb/+fGYJfZ/ya7jKu+5
         Wzv2bzVmFaI597FPMk+e4mANwWD1ei1DjLnVzqk7LE70zEhEgNRCG4QgMM0HnOGS5GMj
         KV2IhC0ZubP7Re//D2WBMYNKzgKCM7AFHzZnlRPKcyBWUoilFKjxxEMwPyIkv6N2tLBS
         JvdWcYZ7oyC3lasMxjWimdp3ipIuc5O5oWji54d8dgoEypJ/JPkz7AGGpuWkz25E/GVQ
         U/2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRo8kKnA5pdSlXRTRC4Ty4lcuDgE2qv1vB3dKf0vaLhNbWSiMnzUrHPQ7XuJviYIv3xTLh3EBemd/rhg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwXIPl4PlvJ1RAzqI931saRzT2if9VeLi7f/cWvBUilp5/HdBQM
	RGqPdMIQvKiL2gbPo3KS2253n+AsdopF5lIY4gcYlmM9qv2daIL5CFXKmY5jU5QlxiSCzfCuS3k
	py+1bJaEESYEtLIIqvdVK8YY050F4nLmtFe4/y7jC+byjUbqpHdrlRp0=
X-Google-Smtp-Source: AGHT+IEhKRVrCZkAhlCW00Rik13sgAiQvqwQSq4s1KNDJWGREPyu0ky6iqCVETttYYF6Aglj4mTYpFWWQDkjO1p1NO5LjUWf7NMW
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3b60558cbmr110829015ab.24.1728985502985; Tue, 15 Oct 2024
 02:45:02 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:45:02 -0700
In-Reply-To: <d38ebf68-46c7-443a-8771-3dbd835a17fd@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e399e.050a0220.d9b66.014e.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         7f773fd6 Add linux-next specific files for 20241014
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241014
console output: https://syzkaller.appspot.com/x/log.txt?x=138ad727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d6083ad781cbf8
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
