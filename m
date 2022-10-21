Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EAA606D13
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 03:38:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtnDN1Ch3z3cDb
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 12:38:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=52.59.177.22; helo=smtpbgeu1.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=<UNKNOWN>)
X-Greylist: delayed 61991 seconds by postgrey-1.36 at boromir; Fri, 21 Oct 2022 12:38:20 AEDT
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtnDD6L3lz2yn3
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 12:38:13 +1100 (AEDT)
X-QQ-mid: bizesmtp70t1666316278t4ekynvp
Received: from [10.20.52.53] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Oct 2022 09:37:57 +0800 (CST)
X-QQ-SSF: 01400000000000B0E000000A0000000
X-QQ-FEAT: RLrSOnjbvYH3GSJfaSqkgCfjUYQUAHDlMAnsy+c85BbF9hDcnkpX4mFmQ2llr
	457QVpZgq5shA5N4aRtgti9g+GhsQwcpOteu96UZDxFN/NZcmslAJrHxcsf/5Wk9cO7WAWP
	9QcY0SpUP7muZYvehYTo86K0RDqO+qj1ZIViUabMOeIKfeGSjDWRXMLyxyhRFKHHZvHJn5Q
	oUZH3rLtNMmg+AuIIe40sCezFsOY7Xyk9C9OjIFsq8QMhVGNN5xDRFTDxNeMiiuL6Vg4U8Q
	QCmUBFUhDMp4JhBUzF9MZH/eN+OUBA9xmXVF0GZhco+QDSnylmWnzvh+HRt7O8w7lX+l21a
	eifbFwAp02qZRwGahBpv1ViTAJUj/9R2BX9D5Gp7i/+jYtZh81DByoW7ClqEw==
X-QQ-GoodBg: 2
Message-ID: <35DADC97C92E6537+142bad0a-97d1-5327-7188-d26c330ef061@uniontech.com>
Date: Fri, 21 Oct 2022 09:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: A little patch fix dev_read to make it works with large file
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <70667519DD94DA0B+b911194e-0b38-9674-eb9f-5ed8d93a3044@uniontech.com>
 <Y1ET0jXRfA7PNEVT@B-P7TQMD6M-0146.local>
From: chenlinxuan <chenlinxuan@uniontech.com>
In-Reply-To: <Y1ET0jXRfA7PNEVT@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
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
Cc: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

 From 83e965dc6ec45e5c9811a27023c9cc213d50816b Mon Sep 17 00:00:00 2001
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Thu, 20 Oct 2022 17:53:03 +0800
Subject: [PATCH] erofs-utils: erofs-utils: lib: fix dev_read

When using `fsck.erofs` to extract some image have a very large file
inside, for example 2G, my fsck.erofs report some thing like this:

<E> erofs_io: Failed to read data from device - erofs.image:[4096,
2147483648].
<E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
<E> erofs: Failed to extract filesystem

You can use this script to reproduce this issue.

mkdir tmp extract
dd if=/dev/urandom of=tmp/big_file bs=1M count=2048

mkfs.erofs erofs.image tmp
fsck.erofs erofs.image --extract=extract

I found that dev_open will failed if we can not get all data we want
with one pread call.

I write this little patch try to fix this issue.

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
  lib/io.c | 28 +++++++++++++++++++++-------
  1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 524cfb4..5cb2b3a 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)

  int dev_read(int device_id, void *buf, u64 offset, size_t len)
  {
-    int ret, fd;
+    int read_count, fd;

      if (cfg.c_dry_run)
          return 0;
@@ -278,15 +278,29 @@ int dev_read(int device_id, void *buf, u64 offset, 
size_t len)
          fd = erofs_blobfd[device_id - 1];
      }

+    while (len > 0) {
  #ifdef HAVE_PREAD64
-    ret = pread64(fd, buf, len, (off64_t)offset);
+        read_count = pread64(fd, buf, len, (off64_t)offset);
  #else
-    ret = pread(fd, buf, len, (off_t)offset);
+        read_count = pread(fd, buf, len, (off_t)offset);
  #endif
-    if (ret != (int)len) {
-        erofs_err("Failed to read data from device - %s:[%" PRIu64 ", 
%zd].",
-              erofs_devname, offset, len);
-        return -errno;
+        if (read_count == -1 || read_count == 0) {
+            if (errno) {
+                erofs_err("Failed to read data from device - "
+                      "%s:[%" PRIu64 ", %zd].",
+                      erofs_devname, offset, len);
+                return -errno;
+            } else {
+                erofs_err("Reach EOF of device - "
+                      "%s:[%" PRIu64 ", %zd].",
+                      erofs_devname, offset, len);
+                return -EINVAL;
+            }
+        }
+
+        offset += read_count;
+        len -= read_count;
+        buf += read_count;
      }
      return 0;
  }
-- 
2.37.3

On 2022/10/20 17:24, Gao Xiang wrote:
> Hi LinXuan,
> 
> On Thu, Oct 20, 2022 at 04:12:57PM +0800, chenlinxuan wrote:
>> When using `fsck.erofs` to extract some image have a very large file (3G)
>> inside, my fsck.erofs report some thing like:
>>
>> <E> erofs_io: Failed to read data from device - erofs.image:[4096,
>> 2147483648].
>> <E> erofs: failed to read data of m_pa 4096, m_plen 2147483648 @ nid 40: -17
>> <E> erofs: Failed to extract filesystem
>>
>> You can use this script to reproduce this issue.
>>
>> #!/bin/env sh
>>
>> mkdir tmp extract
>> dd if=/dev/urandom of=tmp/big_file bs=1M count=2048
>>
>> mkfs.erofs erofs.image tmp
>> fsck.erofs erofs.image --extract=extract
>>
>> I found that dev_open will failed if we can not get all data we want with
>> one pread call.
>>
>> I write this little patch try to fix this issue.
>>
>> This is my first patch send via email, sorry if anything goes wrong.
>>
> 
> Thanks for your report, and the issue looks true.
> 
> In order to merge this patch, could you apply the message above into
> the commit message?
> 
> BTW, the commit message can be updated with "git commit --amend".
> 
>>  From 156af5b173c1f9e2a91e4d2126214b96966babd1 Mon Sep 17 00:00:00 2001
>> From: chenlinxuan <chenlinxuan@uniontech.com>
> 
> It would be better to update your real name into
> "Linxuan Chen" Or "Chen Linxuan" (whichever you prefer).
> 
>> Date: Thu, 20 Oct 2022 14:39:17 +0800
>> Subject: [PATCH] erofs-utils: lib: fix dev_read
> 
> Subject title:
> "erofs-utils: lib: fix dev_read to make it works with large file"
> 
>>
>> We need to keep calling pread until we get all data we want
>> ---
>>   lib/io.c | 28 +++++++++++++++++++++-------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/io.c b/lib/io.c
>> index 524cfb4..bd3d790 100644
>> --- a/lib/io.c
>> +++ b/lib/io.c
>> @@ -256,7 +256,7 @@ int dev_resize(unsigned int blocks)
>>
>>   int dev_read(int device_id, void *buf, u64 offset, size_t len)
>>   {
>> -   int ret, fd;
>> +   int read_count, fd;
>>
>>      if (cfg.c_dry_run)
>>          return 0;
>> @@ -278,15 +278,29 @@ int dev_read(int device_id, void *buf, u64 offset,
>> size_t len)
>>          fd = erofs_blobfd[device_id - 1];
>>      }
>>
>> +   while (len > 0) {
>>   #ifdef HAVE_PREAD64
>> -   ret = pread64(fd, buf, len, (off64_t)offset);
>> +       read_count = pread64(fd, buf, len, (off64_t)offset);
>>   #else
>> -   ret = pread(fd, buf, len, (off_t)offset);
>> +       read_count = pread(fd, buf, len, (off_t)offset);
>>   #endif
>> -   if (ret != (int)len) {
>> -       erofs_err("Failed to read data from device - %s:[%" PRIu64 ",
>> %zd].",
>> -             erofs_devname, offset, len);
>> -       return -errno;
>> +       if (read_count == -1 || read_count ==  0) {
> 
>                                                  ^ extra space here.
> 
> Thanks,
> Gao Xiang
> 
