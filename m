Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3876DD48F
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 09:45:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PwdDS0Jhfz3cfh
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 17:45:28 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com (client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3cxa1zakbacgwcdoeppivettmh.ksskpiywivgsrxirx.gsq@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN>)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PwdDH75Ypz3bfw
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 17:45:18 +1000 (AEST)
Received: by mail-il1-f198.google.com with SMTP id d15-20020a056e020bef00b00325e125fbe5so5271775ilu.12
        for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 00:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681199116; x=1683791116;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbWUqpJCIyP7ZGmwXjgwzNf+FuN/IBe6NUV2pu6zltU=;
        b=2FJxgmwDbN04rT3at/l+Ix1uUOBQv9kz2DmWcsnz8YZUP1KfLrrxNbpzS2gEV/o0zP
         d+aOa5dVQmnib7wp/3URGSXrxP9lhPO2b7nLslqnxjVi97TYcvo7FDRr/mmaWu6T7HLW
         uegqj6QSsH8WleydJnc/beP4iH10JGHTHexLtaB4+Vo2fpHSIpfPdYlylk34dMjRjxys
         b2oxzU9SFg01O38yRUiEbh+HKOMX8HQZsTVWL1QLDAYDC1h3tCzzYxWAJeoimnWAivvh
         +D3f75cu0NjAn22Yk3Fr7oizUFCLU7JPRkBaiUGohOq+qPSIWjpo1qeeJF4we0teM61f
         kRjg==
X-Gm-Message-State: AAQBX9diVlqjJT8B/4wBaFNKufjAOXVYXFZ+Ri9lH5jTvWJhZW68Xi8Y
	6x2gNrSNRoQa9KwTomSlSFfHPHA+YR+3mbnWxr1ZHnBUzOxy
X-Google-Smtp-Source: AKy350bNSCu/PcC8QGr7jRhj27QLgX2g6a+toIV9soxEZ/khEnqLSN2ViGI6A5tkAgSHqE25xe6PU8JKkiJto2MR5IWbSWqMPuOH
MIME-Version: 1.0
X-Received: by 2002:a02:858c:0:b0:3a7:e46e:ab64 with SMTP id
 d12-20020a02858c000000b003a7e46eab64mr5005293jai.1.1681199115991; Tue, 11 Apr
 2023 00:45:15 -0700 (PDT)
Date: Tue, 11 Apr 2023 00:45:15 -0700
In-Reply-To: <d6caf172-7eb6-e664-88c7-581bd0559bb0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b02a505f90aac8d@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in rmqueue
From: syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git//dev-next: failed to run ["git" "fetch" "--force" "2dd127424840ba106193cac6a90d288b6cc7557c" "dev-next"]: exit status 128
fatal: couldn't find remote ref dev-next



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/ dev-next
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       

Note: no patches were applied.
