Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F72FE743
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 11:14:22 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLyt31gWQzDqX1
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Jan 2021 21:14:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=202.38.213.20; helo=mail.scut.edu.cn;
 envelope-from=sehuww@mail.scut.edu.cn; receiver=<UNKNOWN>)
Received: from mail.scut.edu.cn (stumail1.scut.edu.cn [202.38.213.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DLyrV59gkzDrNS
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Jan 2021 21:12:54 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [59.53.40.31])
 by front (Coremail) with SMTP id AWSowACnrweBUwlg6OjZAQ--.65394S3;
 Thu, 21 Jan 2021 18:12:20 +0800 (CST)
Date: Thu, 21 Jan 2021 18:12:33 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: fuse returns ENOENT to openat() for symlink probabilistically
Message-ID: <20210121101233.GC6680@DESKTOP-N4CECTO.huww98.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: AWSowACnrweBUwlg6OjZAQ--.65394S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZF15Xw4kZFW8Ar15CF4fAFb_yoWkKrb_ur
 18Ga98JFsIkw47Ka1a9rsIvF4vqFsFk348Z34Iq3y2gry8X3W8ZayDG3Z5uFyavFsxC3ZI
 kan3Zry7Aw45ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbFxYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
 0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
 6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOoGdUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAHBlepTBDfZQAJsR
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

Hi all,

I'm working on setting up CI service to run tests automatically. Now I have got
tests with kernel mount succeeded. But some tests with fuse fails
probabilistically. Here are my discoveries:

* if I run fssum in tests/src from experimental-tests branch multiple times, it
returns different checksums for the same image and same erofsfuse process.

* if I run "diff -r" on the source and the mounted directories, all file
content matches. but sometimes, diff reports "diff:
test-mount/lib/.libs/liberofs.la: No such file or directory". This file is a
symlink to "../liberofs.la". Then I use strace to confirm that openat() system
call to this path returned ENOENT incorrectly. strace outputs:

openat(AT_FDCWD, "test-mount/lib/.libs/liberofs.la", O_RDONLY) = -1 ENOENT (No such file or directory)

* However, If I just do "cat test-mount/lib/.libs/liberofs.la" several hundreds
of times, I cannot trigger this issue.

* I can reproduce this on both compressed and uncompressed images.

There seems a race condition, but I cannot figure it out. I'm not familiar with
fuse. But I would like to debug further if someone can provide me any advice or
guidance.

Thanks,
Hu Weiwen

