Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0614664DF
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 15:02:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J4d2L1w7Sz2yyv
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Dec 2021 01:02:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=fail (SPF fail - not authorized)
 smtp.mailfrom=mail.scut.edu.cn (client-ip=47.90.88.91;
 helo=aliyun-sdnproxy-2.icoremail.net; envelope-from=sehuww@mail.scut.edu.cn;
 receiver=<UNKNOWN>)
X-Greylist: delayed 717 seconds by postgrey-1.36 at boromir;
 Fri, 03 Dec 2021 01:02:43 AEDT
Received: from aliyun-sdnproxy-2.icoremail.net (aliyun-cloud.icoremail.net
 [47.90.88.91])
 by lists.ozlabs.org (Postfix) with SMTP id 4J4d2C1cxDz2yPN
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Dec 2021 01:02:39 +1100 (AEDT)
Received: from DESKTOP-N4CECTO.huww98.cn (unknown [125.216.246.30])
 by main (Coremail) with SMTP id AQAAfwCXd+AozahhykIhAg--.64206S3;
 Thu, 02 Dec 2021 21:42:07 +0800 (CST)
Date: Thu, 2 Dec 2021 21:42:41 +0800
From: =?utf-8?B?6IOh546u5paH?= <sehuww@mail.scut.edu.cn>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v2] erofs-utils: add Apache 2.0 license
Message-ID: <20211202134241.GA17024@DESKTOP-N4CECTO.huww98.cn>
References: <Yaeq51nipFpzhD7r@B-P7TQMD6M-0146.local>
 <20211202022521.4291-1-huangjianan@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202022521.4291-1-huangjianan@oppo.com>
X-CM-TRANSID: AQAAfwCXd+AozahhykIhAg--.64206S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5Z7k0a2IF6F1UM7kC6x804xWl14x267AK
 xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
 A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
 6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr
 1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY
 62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7V
 C2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
 IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
 87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zi5xhQUUUUU=
X-CM-SenderInfo: qsqrljqqwxllyrt6zt1loo2ulxwovvfxof0/1tbiAQAOBlepTBsLRwAPsj
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 02, 2021 at 10:25:21AM +0800, Huang Jianan via Linux-erofs wrote:
> Let's release liberofs under GPL-2.0+ OR Apache-2.0 license for
> better integration.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>

Acked-by: Hu Weiwen <sehuww@mail.scut.edu.cn>

